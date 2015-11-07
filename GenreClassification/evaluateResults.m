% function [FeatureRanking, classAccuracy, TotalAccuracy, ConfusionMatrix] = evaluateResults(K, features, GroundTruth, nof)

%10x500 feature matrix, 1x500 labels, 5 classes, 100 audios in each
% nof=number of folds
close all;
clear all;
clc;

nof=10;
K=7;
% features=rand(10,500);
% chk=ones(1,100);
% GroundTruth=[chk,2*chk,3*chk,4*chk,5*chk];
[features, GroundTruth] = featureExtraction(2048, 1024);
[classAccuracy, TotalAccuracy, ConfusionMatrix]=CrossValidateNFolds(K, features, GroundTruth, nof);

% sequential forward selection.. nedds to be evaluated with 10 fold cross validation
% number of features
[numFeat,~]=size(features);
% FeatComb

iter=1;
Hierarchy=10:-1:1;
FeatCombNum=cell(sum(1:numFeat),1);
FeatCombAccu=zeros(sum(1:numFeat),1);

for i=1:numFeat
    [~, FeatCombAccu(i), ~]=CrossValidateNFolds(K, features(i,:), GroundTruth, nof);
%     FeatCombNum{i}=i;
end
[val,loc]=max(FeatCombAccu);

featureList=1:numFeat;
NewList=[];
NewList=[NewList;featureList(loc)];
AccuList=[val];
Accu_past=val;


featureList(loc)=[];
Accu_present=Accu_past+0.01;

while Accu_past<Accu_present && isempty(featureList)~=1
    Accu_past=Accu_present;
    AccuArr=zeros(length(featureList),1);
    for iter=1:length(featureList)
        [~, AccuArr(iter), ~]=CrossValidateNFolds(K, [features(featureList(iter),:);features(NewList,:)], GroundTruth, nof);
    
    end
    
    Accu_present=max(AccuArr);
    if Accu_past<Accu_present
        [Accu_present,loc]=max(AccuArr);
        AccuList=[AccuList,Accu_present];
        NewList=[NewList;featureList(loc)];
        featureList(loc)=[];
    end
    
end

% end