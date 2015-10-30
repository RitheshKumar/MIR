function unitTest(sampleFreq,windowSize,hopSize)

	w = 0:2*pi/(sampleFreq):3*2*pi-1/(sampleFreq);
	signalFreq = 441;
	mySignal = sin(signalFreq*w);

	noverlap = windowSize - hopSize;
	nfft     = 5*windowSize;
	[specMat,yFreq,xTime]=spectrogram(mySignal,windowSize,noverlap,nfft,sampleFreq);

	%%% % Test SpectralCentroid 
	% for our sinusoid (singlePeak) we have to get a constant spectral Centroid
	specCentroid  = mySpectralCentroid (specMat) ; 
	if mean(diff(specCentroid)) < 1e-04
		disp('Successful SpectralCentroid');
	else
		disp('SpectralCentroid Failed');
	end

	%%% % Test SpectralCrest 
	% for our sinusoid (singlePeak) we have to get a constant spectral Crest
	specCrest  = mySpectralCrest (specMat) ; 
	if mean(diff(specCrest)) < 1e-04
		disp('Successful SpectralCrest');
	else
		disp('SpectralCrest Failed');
	end

	%%% % Test ZeroCrossingRate
	% The output must be 2*periodLengths/block
	% for our sinusoid, the no. of samples required to represent 1 period = sampleFreq/signalFreq;
	% every block has: 2*windowSize/(sampleFreq/signalFreq);
	%  myTest = [1,-1,-3,3,-4] should give 1/3,1/3,2/3

	zeroCrossingRate = myZeroCrossingRate ( mySignal, windowSize, hopSize );

	samplesInAPeriod = sampleFreq/signalFreq;
	calculatedZeroCrossings = (2*windowSize/samplesInAPeriod)/windowSize;  %normalizing

	%disp(calculatedZeroCrossings);
	%disp(mean(zeroCrossingRate));
	if ( abs(mean(zeroCrossingRate) - calculatedZeroCrossings) < .05*calculatedZeroCrossings )
		disp ('Successful ZeroCrossing');
	else
		disp ('ZeroCrossing Failed');

	end
	    
end

