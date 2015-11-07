clear all;
close all;
clc;

%[audio,sampleFreq] = audioread('/Users/Rithesh/Documents/3rd Sem/TONAS/Deblas/10-D_TalegondeCordoba.wav');
%
%windowSize = 2048; hopSize = 1024;
%noverlap = windowSize - hopSize; nfft = windowSize*5;
%
%[specMat,yFreq,xTime]=spectrogram(audio,windowSize,noverlap,nfft,sampleFreq);
%
%specCentroid  = mySpectralCentroid (specMat) ; 

load ('metaData.mat');

numFolds      = 10;
featureMatrix = metaData;
iterIdx       = 1;
K             = 5;

windowSize    = 2048;
hopSize       = 1024;

% numGenres     = 5;
% genre         = 1:numGenres;
% numFiles      = length ( featureMatrix (1,:) );
% genre         = repmat  (genre, [numFiles/numGenres,1]);
% genre         = reshape (genre, [1, numFiles] );

% [testData, trainData, trainLabel]             = getTestSet (numFolds, featureMatrix, genre, iterIdx);
% [estimatedClass]                              = myKNN (testData, trainData, trainLabel, K);
[zScoreData,genre]                              = featureExtraction(windowSize, hopSize);
[classAccuracy, TotalAccuracy, ConfusionMatrix] = CrossValidateNFolds(K, zScoreData, genre, numFolds);