clear all;
close all;
clc;

[audio,sampleFreq] = audioread('/Users/Rithesh/Documents/3rd Sem/TONAS/Deblas/10-D_TalegondeCordoba.wav');

windowSize = 2048; hopSize = 1024;
noverlap = windowSize - hopSize; nfft = windowSize*5;

[specMat,yFreq,xTime]=spectrogram(audio,windowSize,noverlap,nfft,sampleFreq);

specCentroid  = mySpectralCentroid (specMat) ; 


