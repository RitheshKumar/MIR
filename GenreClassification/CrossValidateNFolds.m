function [classAccuracy, TotalAccuracy, ConfusionMatrix]=CrossValidateNFolds(K, features, GroundTruth, nof)

%10x500 feature matrix, 1x500 labels, 5 classes, 100 audios in each
% nof=number of folds
TotalFiles=length(GroundTruth);
EstNumFilesInAFold=floor(TotalFiles/nof);

FinalNumFilesReqd=EstNumFilesInAFold*nof;

DiffOfFiles=TotalFiles-FinalNumFilesReqd;

NoOfClasses=length(unique(GroundTruth));
NoOfFilesInEachClass=TotalFiles/NoOfClasses;
% assumption: features are arranged as belonging to each class in order

%cell array for different folds
if DiffOfFiles<EstNumFilesInAFold/2 && DiffOfFiles~=0
    %split the files among the different folds
    FinalFolds=cell(nof,2);
    EachGenreInEachFold=floor(NoOfFilesInEachClass/nof);
    for i=1:nof
        for clsIter=1:NoOfClasses
            FinalFolds{i,1}=[FinalFolds{i,1},features(:,(clsIter-1)*NoOfFilesInEachClass+1+EachGenreInEachFold*(i-1):(clsIter-1)*NoOfFilesInEachClass+EachGenreInEachFold*i)];
            FinalFolds{i,2}=[FinalFolds{i,2},GroundTruth((clsIter-1)*NoOfFilesInEachClass+1+EachGenreInEachFold*(i-1):(clsIter-1)*NoOfFilesInEachClass+EachGenreInEachFold*i)];
        
        if i==nof
            lstIter(clsIter)=(clsIter-1)*NoOfFilesInEachClass+EachGenreInEachFold*i;
        end
        end
    end
    
    FilesLeftInEachClass=floor(NoOfFilesInEachClass-EachGenreInEachFold*nof);
    for i=1:FilesLeftInEachClass
        for chk=1:NoOfClasses
            FinalFolds{i,1}=[FinalFolds{i,1},features(:,lstIter(chk)+i)];
            FinalFolds{i,2}=[FinalFolds{i,2},GroundTruth(lstIter(chk)+i)];
        end    
    end

elseif DiffOfFiles==0
    %if equal nof is integer multiple of the number of files
    FinalFolds=cell(nof,2);
    EachGenreInEachFold=NoOfFilesInEachClass/nof;
    for i=1:nof
        for clsIter=1:NoOfClasses
            FinalFolds{i,1}=[FinalFolds{i,1},features(:,(clsIter-1)*NoOfFilesInEachClass+1+EachGenreInEachFold*(i-1):(clsIter-1)*NoOfFilesInEachClass+EachGenreInEachFold*i)];
            FinalFolds{i,2}=[FinalFolds{i,2},GroundTruth((clsIter-1)*NoOfFilesInEachClass+1+EachGenreInEachFold*(i-1):(clsIter-1)*NoOfFilesInEachClass+EachGenreInEachFold*i)];
        end
    end
end

% n fold cross-validation
conf_mat=zeros(NoOfClasses,NoOfClasses);
for iter=1:nof
    trainData=[];
    testData=[];
    trainLabel=[];
    testLabel=[];
    for i=1:nof
        if i~=iter
            trainData=[trainData,FinalFolds{i,1}];
            trainLabel=[trainLabel,FinalFolds{i,2}];
        else
            testData=[testData,FinalFolds{i,1}];
            testLabel=[testLabel,FinalFolds{i,2}];
        end
    end
    
    % call knn to get the estimated class
%    [estimatedClass] = myKnn(testData, trainData, trainLabel, K);          
    [estimatedClass] = myKNN(testData, trainData, trainLabel, K);          

    conf_mat=conf_mat+confusionmat(testLabel, estimatedClass);
end

% Confusion matrix and accuracy
ConfusionMatrix = conf_mat;
TotalAccuracy=trace(ConfusionMatrix)/length(GroundTruth);
classAccuracy=diag(conf_mat)./NoOfFilesInEachClass;

end
