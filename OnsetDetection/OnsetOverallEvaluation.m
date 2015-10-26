fclose all;
clear all;
close all;
clc;

addpath('./ODB/audio');
addpath('./ODB/ground truth');
listingAudios = dir('./ODB/audio/*.wav');
listingAnnotations = dir('./ODB/ground truth/*.txt');

order = 4; lambda = 0.09;
windowSize = 1024; hopSize = 256;
deltaTime = 50;

precisionSF = zeros(1,length(listingAudios)); recallSF = zeros(1,length(listingAudios)); fmeasureSF = zeros(1,length(listingAudios));
precisionPE = zeros(1,length(listingAudios)); recallPE = zeros(1,length(listingAudios)); fmeasurePE = zeros(1,length(listingAudios));
precisionWPD = zeros(1,length(listingAudios)); recallWPD = zeros(1,length(listingAudios)); fmeasureWPD = zeros(1,length(listingAudios));

for i = 1:length(listingAudios)
    groundTruth = load(listingAnnotations(i).name);
    [audio,fs] = audioread(listingAudios(i).name);

    [nvtSF] = mySpectralFlux(audio, windowSize, hopSize);
    [nvtPE] = myPeakEnv(audio, windowSize, hopSize);
    [nvtWPD] = myWPD(audio, windowSize, hopSize);

    [onsetTimeInSecSF] = myOnsetDetection(nvtSF, fs, windowSize, hopSize);
    [onsetTimeInSecPE] = myOnsetDetection(nvtPE, fs, windowSize, hopSize);
    [onsetTimeInSecWPD] = myOnsetDetection(nvtWPD, fs, windowSize, hopSize);

    [precisionSF(i), recallSF(i), fmeasureSF(i)] = evaluateOnsets(onsetTimeInSecSF, groundTruth, deltaTime);
    [precisionPE(i), recallPE(i), fmeasurePE(i)] = evaluateOnsets(onsetTimeInSecPE, groundTruth, deltaTime);
    [precisionWPD(i), recallWPD(i), fmeasureWPD(i)] = evaluateOnsets(onsetTimeInSecWPD, groundTruth, deltaTime);
end;

A = [ mean(precisionSF), mean(recallSF), mean(fmeasureSF);
     mean(precisionPE), mean(recallPE), mean(fmeasurePE);
    mean(precisionWPD), mean(recallWPD),mean(fmeasureWPD)];
A = A'

