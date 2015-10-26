%% Novelty function: weighted phase deviation
% Paper : S. Dixon, 2006, onset detection revisited 
% [nvt] = myWPD(x, windowSize, hopSize)
% input: 
%   x: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   nvt: m by 1 float vector, the resulting novelty function 

function [nvt] = myWPD(x, windowSize, hopSize)

% YOUR CODE HERE: 

    noverlap=windowSize-hopSize;     
    nfft=round(windowSize*1); %window size etc. in samples

    specMat = spectrogram(x,windowSize,noverlap,nfft);
    specMat = [zeros(nfft/2+1,2),specMat];
    phasMat = unwrap(angle(specMat));

    phaseDeviation = (diff(diff(phasMat,1,2),1,2)); 
%     nvt = mean(abs(specMat(:,3:end).*phaseDeviation),1);
    nvt = sum(abs(specMat(:,1:end-2).*phaseDeviation),1);
    nvt = nvt./sum(abs(specMat(:,1:end-2)));
    nvt = nvt';
    
    if sum(nvt)~=0
     nvt = nvt./max(nvt);
    end
   

end
    
