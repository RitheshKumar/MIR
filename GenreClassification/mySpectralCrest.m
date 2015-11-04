% specMat is a k*n matrix with k representing nfft/2 + 1 frequency bins
%			       n representing the time frames

function [spectralCrest] = mySpectralCrest (specMat)

	spectralCrest = zeros(1,length(specMat(1,:)));
    
	for i = 1: length(specMat(1,:))
		spectralCrest(i) = max(abs(specMat(:,i)))/sum(abs(specMat(:,i)));
		if isnan ( spectralCrest(i) )
			spectralCrest(i)  = 0;
		end
	end
end

