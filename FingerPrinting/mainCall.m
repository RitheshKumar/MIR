clear all;
close all;
clc;

% [audio,sampleFreq] = wavread('4notes_train.wav');
[oldAudio,oldSampleFreq] = audioread('/Users/Amruta/Documents/MS GTCMT/Sem1/Computational Music Analysis/Christina Perri - A Thousand Years.wav');

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
