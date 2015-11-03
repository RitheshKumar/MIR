% This function returns a 10x1 vector 
% The features are mean and std of PE, SC, SCR, SF and ZCR respectively

function [featureVector] = getFeatureVector ( audioFile, sampleFreq, windowSize, hopSize )

	noverlap = windowSize - hopSize;
	nfft     = 5*windowSize;

	[specMat, ~, ~] = spectrogram(audioFile, windowSize, noverlap, nfft, sampleFreq);

	peakEnvelope      = myPeakEnv(audioFile, windowSize, hopSize);
	specCentroid      = mySpectralCentroid (specMat) ; 
	specCrest         = mySpectralCrest (specMat) ; 
	specFlux          = mySpectralFlux(specMat) ;
	zeroCrossingRate  = myZeroCrossingRate ( audioFile, windowSize, hopSize );


	featureVector = [ mean(peakEnvelope);	        std(peakEnvelope); 
			  mean(specCentroid);	        std(specCentroid);
			  mean(specCrest);	        std(specCrest);
			  mean(specFlux);	        std(specFlux);
			  mean(zeroCrossingRate);	std(zeroCrossingRate); ]; %I know this is lame. Lets blame time

end
