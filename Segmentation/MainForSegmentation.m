% - Use the provided audio file and annotation for the following questions
% - For consistency of the results, please use spectrogram( ) for computing your spectral features 
% with the following parameterization: windowSize = 4*fs; hopSize = 1/4 * windowSize. 
% The audio file should be down-mix to mono by the following operation: x = mean(x, 2);

fclose all;
close all;
clear all;
clc;

[audio,fs] = audioread('03-Sargon-Waiting For Silence.mp3');

windowSize = 4*fs;
hopSize = 1/4 * windowSize;
audio = mean(audio, 2);

%% Compute the SDMs using two features: MFCC and Pitch Chroma (you may use your implementation from the previous in class exercise and MFCC 

nfft=windowSize;
noverlap=windowSize-hopSize;
[specMat,yFreq,xTime]=spectrogram(audio,windowSize,noverlap,nfft,fs);

[vpc] = FeatureSpectralPitchChroma(abs(specMat), fs);
[vmfcc] = FeatureSpectralMfccs(abs(specMat), fs);

[rwVPC,clVPC]=size(vpc);
NormVPC = zeros (rwVPC,clVPC);
for i=1:rwVPC
    NormVPC(i,:)=(vpc(i,:)-min(vpc(i,:)))./(max(vpc(i,:))-min(vpc(i,:)));
end

[rwMFCC,clMFCC]=size(vmfcc);
NormVMFCC = zeros (rwMFCC,clMFCC);
for i=1:rwMFCC
    NormVMFCC(i,:)=(vmfcc(i,:)-min(vmfcc(i,:)))./(max(vmfcc(i,:))-min(vmfcc(i,:)));
end

% SDM for features
featureMatrix=NormVPC';
[SDMVPC] = computeSelfDistMat(featureMatrix);

featureMatrix=NormVMFCC';
[SDMVMFCC] = computeSelfDistMat(featureMatrix);


%% novelty plotting
% read annotation
FileName='03-Sargon-Waiting For Silence.csv';
fileID  = fopen(FileName);
C = textscan ( fileID, '%f%s', 'delimiter',',');
time  = C{1}; section = C{2};
time=round(time);

L=2;
[nvtVPC1] = computeSdmNovelty(SDMVPC, L);
nvtVPC1=normalizeZeroToOne(nvtVPC1');
figure; title('Novelty for Chroma');
subplot(311); plot(nvtVPC1); title('L=2');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

L=8;
[nvtVPC2] = computeSdmNovelty(SDMVPC, L);
nvtVPC2=normalizeZeroToOne(nvtVPC2');

subplot(312); plot(nvtVPC2); title('L=8');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

L=16;
[nvtVPC3] = computeSdmNovelty(SDMVPC, L);
nvtVPC3=normalizeZeroToOne(nvtVPC3');

subplot(313); plot(nvtVPC3); title('L=16');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

L=2;
[nvtMFCC1] = computeSdmNovelty(SDMVMFCC, L);
nvtMFCC1=normalizeZeroToOne(nvtMFCC1');

figure; title('Novelty for MFCCs');
subplot(311); plot(nvtMFCC1); title('L=2');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

L=8;
[nvtMFCC2] = computeSdmNovelty(SDMVMFCC, L);
nvtMFCC2=normalizeZeroToOne(nvtMFCC2');

subplot(312); plot(nvtMFCC2); title('L=8');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

L=16;
[nvtMFCC3] = computeSdmNovelty(SDMVMFCC, L);
nvtMFCC3=normalizeZeroToOne(nvtMFCC3');

subplot(313); plot(nvtMFCC3); title('L=16');
for i=1:length(time)
   hold on;
   xval=[time(i) time(i)];
   yval=[0 1];
   plot(xval,yval,'k');
end

%% Lag Distance Matrix
Rvpc = computeLagDistMatrix(SDMVPC);
figure; imagesc(Rvpc);title('Lag Distance Matrix with Chroma')

Rmfcc = computeLagDistMatrix(SDMVMFCC);
figure;imagesc(Rmfcc);title('Lag Distance Matrix with MFCCs');

%% Binarization
threshold=0.5;

% NormSDMmfcc=(SDMVMFCC-min(min(SDMVMFCC)))./(max(max(SDMVMFCC))-min(min(SDMVMFCC)));
% [SDM_binaryMFCC] = computeBinSdm(NormSDMmfcc, threshold);
% figure;imagesc(SDM_binaryMFCC);
% colormap gray;
% title('Binary SDM MFCC with threshold=0.5');
% 
% NormSDMvpc=(SDMVPC-min(min(SDMVPC)))./(max(max(SDMVPC))-min(min(SDMVPC)));
% [SDM_binaryVPC] = computeBinSdm(NormSDMvpc, threshold);
% figure;imagesc(SDM_binaryVPC);
% colormap gray;
% title('Binary SDM Chroma with threshold=0.5');

NormSDMmfcc=(Rmfcc-min(min(Rmfcc)))./(max(max(Rmfcc))-min(min(Rmfcc)));
[SDM_binaryMFCC] = computeBinSdm(NormSDMmfcc, 0.35);
figure;imagesc(SDM_binaryMFCC);
colormap gray;
title('Binary SDM MFCC with threshold=0.35');

NormSDMvpc=(Rvpc-min(min(Rvpc)))./(max(max(Rvpc))-min(min(Rvpc)));
[SDM_binaryVPC] = computeBinSdm(NormSDMvpc, 0.4);
figure;imagesc(SDM_binaryVPC);
colormap gray;
title('Binary SDM Chroma with threshold=0.4');

%% erode dilate
L=5;
[SDM_edMFCC] = erodeDilate(Rmfcc, L);
figure;imagesc(SDM_edMFCC);
colormap gray;
title('Erosion on MFCC');

[SDM_edvpc] = erodeDilate(Rvpc, L);
figure;imagesc(SDM_edvpc);
colormap gray;
title('Erosion on Chroma');
