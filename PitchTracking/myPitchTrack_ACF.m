% Blockwise Pitch Tracking based on ACF
% [f0, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   f0 = numBlocks*1 float vector, detected pitch (Hz) per block
%   timeInSec  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [f0, timeInSec] = myPitchTrack_ACF(x, windowSize, hopSize, fs)

% Please write your code here
x=x';
f0=zeros(1,length(0:hopSize:length(x)));
timeInSec=0:hopSize/fs:(length(x))/fs;

n=1;
x=[zeros(1,ceil(windowSize/2)),x,zeros(1,ceil(windowSize/2))];

for i=ceil(windowSize/2):hopSize:length(x)-windowSize
   x1 = x(i:i+windowSize);
   x2 = x1;
   x1 = [zeros(1,length(x1)-1),x1];
   x2 = [x2,zeros(1,length(x2)-1)];
   aucorr = zeros(1,length(x2)-1);
   for k=0:length(x2)-1
       temp = circshift(x2,[0,k]);
       aucorr(k+1)= sum(x1.*temp);
   end
   [~,peak1]=max(aucorr);
   %we assume that the lowest and highest frequencies are 50Hz and 10kHz
   %respectively
   n_min=round(fs/10000);
   n_max=round(fs/50);
   [vals,peak2]=findpeaks(aucorr(peak1+n_min+1:peak1+n_max));
   [~,indx]=max(vals);
   peak2=peak2(indx);
   f0(n)=fs/(peak2+n_min);
   n=n+1;
end
   f0=f0';
   timeInSec=timeInSec';
end
   
