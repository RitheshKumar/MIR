%% Adaptive threshold: median filter
% [thres] = myMedianThres(nvt, order, lambda)
% input: 
%   nvt: m by 1 float vector, the novelty function
%   order: int, size of the sliding window in samples
%   lambda: float, a constant coefficient for adjusting the threshold
% output:
%   thres = m by 1 float vector, the adaptive median threshold

function [thres] = myMedianThres(nvt, order, lambda)

% YOUR CODE HERE: 
    %windowCount = ceil(length(nvt)/order);
    %nvtLen = windowCount*order;
    %nvtMedian = zeros(nvtLen,1);
    %nvtMedian(1:length(nvt)) = nvt;

    hopSize = 1;
    nvtMedian = buffer(nvt,order,order-hopSize);
    nvtMedian = median(nvtMedian,1)+lambda;
    
    thres = repmat(nvtMedian,hopSize,1);
    thres = reshape(thres,length(nvtMedian)*(hopSize),1);

end
