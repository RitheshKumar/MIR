% specMat is a k*n matrix with k representing nfft/2 + 1 frequency bins
%			       n representing the time frames

function [spectralCrest] = mySpectralCrest (specMat)

	spectralCrest = zeros(1,length(specMat(1,:)));
    
	for k = 1: length(specMat(1,:))
		spectralCrest(k) = max(abs(specMat(:,k)))/sum(abs(specMat(:,k)));
	end
end

