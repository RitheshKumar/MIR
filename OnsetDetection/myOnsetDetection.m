%% onset detection with adaptive thresholding
% [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   fs: float, sampling frequency in Hz
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   onsetTimeInSec: n by 1 float vector, onset time in second

function [onsetTimeInSec] = myOnsetDetection(nvt, fs, windowSize, hopSize)

% YOUR CODE HERE: 
    order = 4; lambda = 0.09;
    thres = myMedianThres(nvt, order, lambda);
    nvt(nvt<thres) = 0;
    [~,onsetLoc] =findpeaks(nvt);
    onsetTimeInSec = onsetLoc*hopSize/fs;

end


