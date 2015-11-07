%% Function: myKNN 
% [estimatedClass] = myKNN (testData, trainData, trainLabel, K)
% input: 
%   testData:   testData is your vectorSet for testing, you have to estimate classes for these
%   trainData:  trainData is your vectorSet for training
%   trainLabel: the labels of your trainData 
%   K         : no of neighbours
% output: 
%   estimatedClass: a vector giving genre estimates for each dataPoint in testData

function [estimatedClass] = myKNN (testData, trainData, trainLabel, K)
    
    numTestPoints  = length (testData  (1, :) );
    numTrainPoints = length (trainData (1, :) );

    distance       = zeros (1, numTrainPoints);
    estimatedClass = zeros (1, numTestPoints);

    for i = 1: numTestPoints

        testVec  = testData (:, i);

        for k = 1: numTrainPoints
            
            diffMat      = testVec - trainData (:, k);
            distance (k) = sqrt (sum (diffMat.^2) );

        end

        % must definitely revise this part!! now I am just taking the minimum max occurence
        [DistStore, sortIdx]           = sort (distance);
        labelIdx               = sortIdx(1:K);
        kClasses        = trainLabel (labelIdx);      % KClasses has 5 elements! (classes corresponding to 5 shortest distances)
        ConcatDistLabel=[kClasses' DistStore(1:K)'];
        SortedDistLabel=sortrows(ConcatDistLabel);
        SortedDistLabel=SortedDistLabel';
        LabelOccur = (hist (SortedDistLabel(1,:), [1:5] ) );  % 5 since we have 5 classes
        LabelOccur=[LabelOccur;1:5];
        SortedLabelOccur=sortrows(LabelOccur');
        SortedLabelOccur=flip(SortedLabelOccur);
        
        for j=1:length(SortedLabelOccur)-1
            changeIdx=SortedLabelOccur(j,1)-SortedLabelOccur(j+1,1);
            if changeIdx~=0
                Idx=j;
                break;
            end
        end
        
        if Idx==1
            [~,estimatedClass(i)]=max(hist (SortedDistLabel(1,:), [1:5] ));
        else
            NewDist=[];
            for k=1:Idx
                Idxs=find(SortedDistLabel(1,:)==SortedLabelOccur(k,2));
                NewDist(k)=mean(SortedDistLabel(2,Idxs));
            end
            [~, minIndx] = min(NewDist);
            estimatedClass (i)  = SortedLabelOccur(minIndx,2);
        end
            
    end

end


    

