function unitTest(sampleFreq,windowSize,hopSize)

	noverlap = windowSize - hopSize;
	nfft     = 5*windowSize;
	spectralTest();
	onsetsTest();


	function spectralTest()

		w = 0:2*pi/(sampleFreq):3*2*pi-1/(sampleFreq);
		signalFreq = 441;
		mySignal = sin(signalFreq*w);

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

	%% The other tests are going to be copy-pasted from previous assignment: cause, time.
	function onsetsTest()
		
		% % Test signal 1
		A=0.5;
		f=441;
		fs=44100;
		step1=1/fs;
		t1=0:step1:(1-step1);
		x1=A*cos(2*pi*f*t1);

		f=882;
		% step2=f/fs;
		% t2=1:step2:2;
		t2=1:step1:2;

		x1=[x1 A*cos(2*pi*f*t2)];
		x1=x1';
		tsig1=[t1 t2];

		% figure; plot(tsig1,x1);

		% Test signal 2
		f=441;
		t3=0:step1:(1-step1);
		x2=A*cos(2*pi*f*t3);

		A2=0.9;
		t4=1:step1:2;
		x2=[x2 A2*cos(2*pi*f*t4)];

		x2=x2';

		tsig2=[t3 t4];

		%basically, x1 and x2 are our required testSignals
		
		specMat1 = spectrogram(x1,windowSize,noverlap,nfft,sampleFreq);
		specMat2 = spectrogram(x2,windowSize,noverlap,nfft,sampleFreq);


		[nvt1] = mySpectralFlux(specMat1) ;
		[val1,loc1]=max(nvt1);
		PeakNovSpecFluxsig1=loc1*hopSize/fs;

		[nvt3] = mySpectralFlux(specMat2) ;
		[val3,loc3]=max(nvt3);
		PeakNovSpecFluxsig2=loc1*hopSize/fs;

		[nvt2] = myPeakEnv(x1', windowSize, hopSize);
		[val4,loc4]=max(nvt2);
		PeakNovEnvsig1=loc4*hopSize/fs;

		[nvt4] = myPeakEnv(x2', windowSize, hopSize);
		[val4,loc4]=max(nvt4);
		PeakNovEnvsig2=loc4*hopSize/fs;

		tsig3=0:(hopSize/fs):2;
		figure; plot(tsig3(1:length(nvt1)),nvt1); figure; plot(tsig3(1:length(nvt2)),nvt2);
		figure; plot(tsig3(1:length(nvt3)),nvt3); figure; plot(tsig3(1:length(nvt4)),nvt4);
	end

end

