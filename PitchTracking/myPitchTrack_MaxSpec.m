%% Blockwise Pitch Tracking based on Maximum Peak of Spectrum
% [f0, timeInSec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process 1024
%   hopSize = int, hop size of the blockwise process 512
%   fs = float, sample rate in Hz
% Output:
%   f0 = numBlocks*1 float vector, detected pitch (Hz) per block
%   timeInSec  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [f0, timeInSec] = myPitchTrack_MaxSpec(x, windowSize, hopSize, fs)

% Please write your code here

timeStamp=hopSize/fs;    % hop in terms of time
totalTime=length(x)/fs;  % x in terms of time
timeInSec=0:timeStamp:totalTime;
midWin=windowSize/2;

fftSize=32*windowSize;
p=0:(fftSize/2)-1;
h=p*(1/((fftSize/2)-1))*(fs/2);
    
hammWin=hamming(windowSize);
f0=zeros(length(timeInSec),1);

cnt=0;
for loop=1:hopSize:length(x)
    
    if loop-midWin<1
        win_x=hammWin.*[zeros(midWin-loop,1);x(1:loop+midWin)];
    elseif loop-midWin>=1 && loop<=length(x)-midWin
        win_x=hammWin.*x(loop-midWin:loop+midWin-1);
    elseif loop>length(x)-midWin
        win_x=hammWin.*[x(loop:length(x));zeros(windowSize-(length(x)-loop)-1,1)];
    end
    
    y=0;
    y=abs(fft(win_x,fftSize));
    len=length(y);
    y_hlf=y(1:len/2);
    maxAmp=(y_hlf==max(y_hlf(2:end)));
    cnt=cnt+1;
    f0(cnt)=h(maxAmp);
    
       
end