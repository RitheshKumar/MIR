% function [FeatureRanking, classAccuracy, TotalAccuracy, ConfusionMatrix] = evaluateResults(K, features, GroundTruth, nof)

%10x500 feature matrix, 1x500 labels, 5 classes, 100 audios in each
% nof=number of folds
close all;
clear all;
clc;
<<<<<<< HEAD
nof=10;
=======
nof=4;
>>>>>>> master
K=3;
features=rand(10,500);
chk=ones(1,100);
GroundTruth=[chk,2*chk,3*chk,4*chk,5*chk];
[classAccuracy, TotalAccuracy, ConfusionMatrix]=CrossValidateNFolds(K, features, GroundTruth, nof);

<<<<<<< HEAD
% sequential forward selection.. nedds to be evaluated with 10 fold cross validation
% number of features
[numFeat,~]=size(features);
% FeatComb

iter=1;
Hierarchy=10:-1:1;
FeatCombNum=cell(sum(1:numFeat),1);
FeatCombAccu=cell(sum(1:numFeat),1);
if iter<=numFeat
    
    for i=1:numFeat
        [~, TotalAccuracy, ~]=CrossValidateNFolds(K, features, GroundTruth, nof);
    
    end
    iter=iter+1;
end

=======
>>>>>>> master
% end