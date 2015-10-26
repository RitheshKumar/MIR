%% Novelty function: spectral flux
% [nvt] = myPeakEnv(x, w, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: n by 1 float vector, the resulting novelty function 

function [nvt] = mySpectralFlux(x, windowSize, hopSize)

% YOUR CODE HERE: 
%     sampleFreq = 44100;
    noverlap=windowSize-hopSize;

%     audio = audioMatrixToVector(x);
    nfft=round(windowSize*5); %window size etc. in seconds
    
    [specMat,yFreq,xTime]=spectrogram(x,windowSize,noverlap,nfft);

    
%     [specMat,yFreq,xTime] = mySpectrogram(x,windowSize,noverlap);
    DiffSpec=diff(abs(specMat),1,2);
    DiffSpec(DiffSpec<0) = 0;   %HWR
    SqrdDiff=DiffSpec.^2;
    nvt = sqrt(sum(SqrdDiff))./(nfft/2+1);
    nvt=nvt';

    if sum(nvt)~=0
     nvt = nvt./max(nvt);
    end
end
