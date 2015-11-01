% function [FeatureRanking, classAccuracy, TotalAccuracy, ConfusionMatrix] = evaluateResults(K, features, GroundTruth, nof)

%10x500 feature matrix, 1x500 labels, 5 classes, 100 audios in each
% nof=number of folds
close all;
clear all;
clc;
nof=6;
K=3;
features=rand(10,500);
chk=ones(1,100);
GroundTruth=[chk,2*chk,3*chk,4*chk,5*chk];
[classAccuracy, TotalAccuracy, ConfusionMatrix]=CrossValidateNFolds(K, features, GroundTruth, nof);

% end