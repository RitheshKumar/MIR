%% Function: myKNN 
% [estimatedClass] = myKNN (testData, trainData, trainLabel, K)
% input: 
%   testData:   testData is your vectorSet for testing, you have to estimate classes for these
%   trainData:  trainData is your vectorSet for training
%   trainLabel: the labels of your trainData 
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
            distance (k) = sqrt (sum (diffMat).^2 );

        end

        % must definitely revise this part!! now I am just taking the minimum max occurence
        [~, sortIdx]           = sort (distance);
        labelIdx               = sortIdx(1:K);
        kClasses               = trainLabel (labelIdx);
        [~, estimatedClass(i)] = max (hist (kClasses, 5) );  % 5 since we have 5 classes
        
    end

end


    

