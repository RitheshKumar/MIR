%% Function: getTestSet 
% [testData, trainData, trainLabel] = getTestSet (numFolds, featureMatrix, genres, iterIdx)
% input: 
%   genre         : a vector with groundTruth genres for each dataPoint in featureMatrix
%   numFolds      : number of folds in cross validation
%   featureMatrix : the dataSet used for validation
%   iterIdx       : tells us which fold to take
% output: 
%   testData:   testData is your vectorSet for testing, you have to estimate classes for these
%   trainData:  trainData is your vectorSet for training
%   trainLabel: the labels of your trainData 

function [testData, trainData, trainLabel] = getTestSet (numFolds, featureMatrix, genres, iterIdx)

     numDataPoints = length (featureMatrix (1, :) );
     testData      = featureMatrix (:, iterIdx:numFolds:end); 

     trainData     = featureMatrix; 
     trainData (:, iterIdx:numFolds:end) = [];

     trainLabel    = genres;
     trainLabel (:, iterIdx:numFolds:end) = [];

end
     
