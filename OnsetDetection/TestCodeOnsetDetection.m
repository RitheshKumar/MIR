close all;
fclose all;
clear all;
clc;

windowSize=1024;
hopSize=256;
order =50;
lambda=0;

% % generate two test signals: x1(t) = A*cos(2*pi*f*t), let {A = 0.5, f = 441 for 0 <= t < 1} and {A = 0.5, f = 882 for 1 <= t <= 2}), x2(t) = A*cos(2*pi*f*t), 
% % let {A = 0.5, f = 441 for 0 <= t < 1} and {A = 0.9, f = 441 for 1 <= t <= 2})
% 
% % Test signal 1
A=0.5;
f=441;
fs=44100;
step1=1/fs;
t1=0:step1:(1-step1);
x1=A*cos(2*pi*f*t1);

f=882;
% step2=f/fs;
% t2=1:step2:2;
t2=1:step1:2;

x1=[x1 A*cos(2*pi*f*t2)];
x1=x1';
tsig1=[t1 t2];

% figure; plot(tsig1,x1);

% Test signal 2
f=441;
t3=0:step1:(1-step1);
x2=A*cos(2*pi*f*t3);

A2=0.9;
t4=1:step1:2;
x2=[x2 A2*cos(2*pi*f*t4)];

x2=x2';

tsig2=[t3 t4];
% figure; plot(tsig2,x2)



[nvt1] = mySpectralFlux(x1, windowSize, hopSize) ;
[val1,loc1]=max(nvt1);
PeakNovSpecFluxsig1=loc1*hopSize/fs;
display(PeakNovSpecFluxsig1);

[nvt3] = mySpectralFlux(x2, windowSize, hopSize) ;
[val3,loc3]=max(nvt3);
PeakNovSpecFluxsig2=loc1*hopSize/fs;
display(PeakNovSpecFluxsig2);

[nvt2] = myPeakEnv(x1, windowSize, hopSize);
[val4,loc4]=max(nvt2);
PeakNovEnvsig1=loc4*hopSize/fs;
display(PeakNovEnvsig1);

[nvt4] = myPeakEnv(x2, windowSize, hopSize);
[val4,loc4]=max(nvt4);
PeakNovEnvsig2=loc4*hopSize/fs;
display(PeakNovEnvsig2);

tsig3=0:(hopSize/fs):2;
figure; plot(tsig3(1:length(nvt1)),nvt1); figure; plot(tsig3(1:length(nvt2)),nvt2);
figure; plot(tsig3(1:length(nvt3)),nvt3); figure; plot(tsig3(1:length(nvt4)),nvt4);

%test code fnctn3
[nvt5] = myWPD(x1, windowSize, hopSize);
[val5,loc5]=max(nvt5);
PeakNovWPDsig1=loc5*hopSize/fs;
display(PeakNovWPDsig1);

[nvt6] = myWPD(x2, windowSize, hopSize);
[val6,loc6]=max(nvt6);
PeakNovWPDsig2=loc6*hopSize/fs;
display(PeakNovWPDsig2);

tsig3=0:(hopSize/fs):2;

[thres5] = myMedianThres(nvt5, order, lambda);
[thres6] = myMedianThres(nvt6, order, lambda);
figure; plot(tsig3(1:length(nvt5)),nvt5); hold on; plot(tsig3(1:length(nvt5)),thres5);
figure; plot(tsig3(1:length(nvt6)),nvt6); hold on; plot(tsig3(1:length(nvt6)),thres6);


%test code Question4
order = 15; lambda = 0.2;
[testAudio,sampleFreq] = audioread('./ODB/audio/2-artificial.wav');
testAudio = audioMatrixToVector(testAudio);
[detectedOnsets] = myWPD(testAudio,windowSize,hopSize);
% detectedOnsets = detectedOnsets./max(detectedOnsets);
[thres7] = myMedianThres(detectedOnsets, order, lambda);

figure; plot(detectedOnsets,'r');hold on; plot(thres7,'g')

order = 4; lambda = 0.09;
[onsetTimeInSec1] = myOnsetDetection(nvt1, fs, windowSize, hopSize);
[thres1] = myMedianThres(nvt1, order, lambda);
[onsetTimeInSec3] = myOnsetDetection(nvt3, fs, windowSize, hopSize);
[thres3] = myMedianThres(nvt3, order, lambda);

figure; plot(tsig3(1:length(nvt1)),nvt1,'r'); hold on; plot(tsig3(1:length(thres1)),thres1,'g');
figure; plot(tsig3(1:length(nvt3)),nvt3,'r'); hold on; plot(tsig3(1:length(thres3)),thres3,'g');
% 
% deltaTime=50;
% load('testEval.mat');
% [precision, recall, fmeasure] = evaluateOnsets(test, ref, deltaTime)
