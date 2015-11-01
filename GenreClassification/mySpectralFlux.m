% specMat is a k*n matrix with k representing nfft/2 + 1 frequency bins
%			       n representing the time frames

function [spectralFlux] = mySpectralFlux (specMat)
	
	DiffSpec=diff(abs(specMat),1,2);
	DiffSpec(DiffSpec<0) = 0;   %HWR
	SqrdDiff=DiffSpec.^2;

	spectralFlux = sqrt(sum(SqrdDiff))./(length(specMat(:,1)));
	spectralFlux=spectralFlux';

	if sum(spectralFlux)~=0
		spectralFlux = spectralFlux./max(spectralFlux);
	end

end

