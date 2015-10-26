%% Novelty function: peak envelope
% [nvt] = myPeakEnv(x, w, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: n by 1 float vector, the resulting novelty function 

function [nvt] = myPeakEnv(x, windowSize, hopSize)

% YOUR CODE HERE: 

%     x = audioMatrixToVector(x);

    % Make the length of the audio to become a whole size
    %   numHops*hopSize + windowSize = length(x) : if numHops is a whole no. 
    %   Therefore, adjust the length such that numHops is a whole no.
    xlen = length(x);
    numHops = ceil((xlen - windowSize)/hopSize);
    newxlen = numHops*hopSize + windowSize;
    x = [x;zeros(newxlen-xlen,1)];
 
    envlp = zeros(numHops,1);
    cnt=0;
    for i = 1:hopSize:length(x)-windowSize
        cnt=cnt+1;
        envlp(cnt) = max(abs(x(i:i+windowSize)));
    end

    nvt=diff(envlp);
    nvt(nvt<0) = 0;  %HWR
    
    if sum(nvt)~=0
     nvt = nvt./max(nvt);
    end

end
