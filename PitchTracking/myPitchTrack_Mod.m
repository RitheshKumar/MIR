%% Blockwise Pitch Tracking using Modified Approach
% [pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs)
% Input:
%   x = N*1 float vector, input signal
%   windowSize = int, window size of the blockwise process
%   hopSize = int, hop size of the blockwise process
%   fs = float, sample rate in Hz
% Output:
%   pitch = numBlocks*1 float vector, detected pitch (Hz) per block
%   time  = numBlocks*1 float vector, time stamp (sec) of each block
% CW @ GTCMT 2015

function [pitch, time] = myPitchTrack_Mod(x, windowSize, hopSize, fs,annotation)


%% Please write your code here
[estimation_MaxSpec,timeEst_MaxSpec]=myPitchTrack_MaxSpec(x, windowSize, hopSize, fs);

[estimation_ACF,timeEst_ACF]=myPitchTrack_ACF(x, windowSize, hopSize, fs);

fLengthLpInS    = 0.002;
iLengthLp       = ceil(fLengthLpInS*fs);
b               = ones(iLengthLp,1)/iLengthLp;
 
mAvg_ACF = filtfilt(b,1,estimation_ACF);
mAvg_MaxSpec = filtfilt(b,1,estimation_MaxSpec);

 
med_ACF = medfilt1(estimation_ACF,9);
med_MaxSpec = medfilt1(estimation_MaxSpec,9);
 
%% If you want to make subplots
 subplot(2,1,1);
 hold on;
 plot(timeEst_ACF,mAvg_ACF,'g');
 plot(timeEst_ACF,med_ACF,'r');
 blot(timeEst_ACF,annotation);
 plot(timeEst_ACF,estimation_ACF,'k');
 legend('mAvg','median','Annotation','Estimation');
 title('ACF');
 
 subplot(2,1,2);
 hold on;
 plot(timeEst_MaxSpec,mAvg_MaxSpec,'g');
 plot(timeEst_MaxSpec,med_MaxSpec,'r');
 blot(timeEst_MaxSpec,annotation);
 plot(timeEst_MaxSpec,estimation_MaxSpec,'k');
 legend('mAvg','median','Annotation','Estimation');
 title('MaxSpec');

 %% Optimisation
 pitch = min(mAvg_MaxSpec,mAvg_ACF);
 time  = timeEst_MaxSpec;
 
end
 
 
 
 

