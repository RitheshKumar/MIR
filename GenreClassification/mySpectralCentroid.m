% specMat is a k*n matrix with k representing nfft/2 + 1 frequency bins
%			       n representing the time frames

function [spectralCentroid] = mySpectralCentroid (specMat)
	
	magnitudeSquared = abs(specMat).^2;
	
	binIndex = 0:length(specMat(:,1))-1;
	
	spectralCentroid = zeros(1,length(specMat(1,:)));
    
	for i = 1: length(specMat(1,:))
		spectralCentroid(i) = sum(magnitudeSquared(:,i).*binIndex')/sum(magnitudeSquared(:,i));
	end;
end

