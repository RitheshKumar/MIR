function unitTest(sampleFreq,windowSize,hopSize)

	w = 0:2*pi/(3*sampleFreq):2*pi-1/(3*sampleFreq);
	signalFreq = 441;
	mySignal = sin(signalFreq*w);
	noverlap = windowSize - hopSize;
	nfft     = 5*windowSize;

	%%% % Test SpectralCentroid 
	% for our sinusoid (singlePeak) we have to get a constant spectral Centroid
	[specMat,yFreq,xTime]=spectrogram(mySignal,windowSize,noverlap,nfft,sampleFreq);
	specCentroid  = mySpectralCentroid (specMat) ; 

	%%% % Test ZeroCrossingRate
	% The output must be 2*periodLengths/block
	% for our sinusoid, the no. of samples required to represent 1 period = sampleFreq/signalFreq;
	% every block has: 2*windowSize/(sampleFreq/signalFreq);

	zeroCrossingRate = myZeroCrossingRate ( mySignal, windowSize, hopSize );

	samplesInAPeriod = sampleFreq/signalFreq;
	calculatedZeroCrossings = 2*windowSize/samplesInAPeriod;

	disp(calculatedZeroCrossings);
	disp(mean(zeroCrossingRate));
	if ( abs(mean(zeroCrossingRate) - calculatedZeroCrossings) < round(.05*samplesInAPeriod) )
		disp ('Successful ZeroCrossing');
	else
		disp ('ZeroCrossing Failed');

    end
    
end

