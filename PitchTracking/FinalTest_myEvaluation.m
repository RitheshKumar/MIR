close all;
clear all;
clc;


% file='63-M2_AMairena';
% file='01-D_AMairena';
file='24-M1_AMairena-Martinete';

path='./trainData';
GTtestfile=load([path '/' file '.f0.Corrected.txt']);
annotation=[GTtestfile(:,3)];
timeAnno=GTtestfile(:,1);
x=wavread([path '/' file '.wav']);

windowSize=1024;
hopSize=512;
fs=44100;

[estimation_MaxSpec,timeEst_MaxSpec]=myPitchTrack_MaxSpec(x, windowSize, hopSize, fs);
[errCent_rms_MaxSpec] = myEvaluation(estimation_MaxSpec, annotation);

[estimation,timeEst]=myPitchTrack_ACF(x, windowSize, hopSize, fs);
[errCent_rms_ACF] = myEvaluation(estimation, annotation);

subplot(2,1,1);
hold on;
plot(timeEst,estimation);
blot(timeEst,annotation);
title('ACF');
 
subplot(2,1,2);
hold on;
plot(timeEst_MaxSpec,estimation_MaxSpec)
blot(timeEst_MaxSpec,annotation);
title('MaxSpec');

[pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs, annotation);
[errCent_rms_mod] = myEvaluation(pitch, annotation);
figure; plot(time, pitch); hold on; plot(timeAnno,annotation,'r'); hold on; plot(timeEst,estimation,'k'); hold on; plot(timeEst_MaxSpec,estimation_MaxSpec,'g');