clear all;
close all;
clc;

% [audio,sampleFreq] = wavread('4notes_train.wav');
[oldAudio,oldSampleFreq] = audioread('/Users/Rithesh/Documents/MIR/Projects/FingerPrinting_Supplies/FingerprintingData/088 - The Temptations - My Girl.mp3');

% possible downsampling goes here
% downSampleFactor =2;    
% audio = downsample(audio,downSampleFactor);
% sampleFreq = sampleFreq/downSampleFactor;
sampleFreq = 16000; %not giving importance to High Frequency Content
audio = resample(oldAudio,sampleFreq,oldSampleFreq);

windowSize = 0.04; noverlap = 0.75;
timeDistance = 5; pitchDistance = 5;
nfft=round(windowSize*sampleFreq*noverlap*5);
prcntPks  = 2/100;

[specMat,yFreq,xTime] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);
[peakLocation] = findSalientPeaks(specMat,pitchDistance,prcntPks,yFreq);
plotSalientPeaks(peakLocation,xTime,yFreq,specMat);

elimCriteria = 20;
reducedPkLoc=reduceDensity(peakLocation,yFreq,elimCriteria);
figure
plotSalientPeaks(reducedPkLoc,xTime,yFreq,specMat);
