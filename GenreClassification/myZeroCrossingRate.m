function [zeroCrossingRate] = myZeroCrossingRate( audio, windowSize, hopSize )
	
	audio = audioResize( audio, windowSize, hopSize );

	zeroCrossingRate = zeros(1, ceil( length(audio)/hopSize ) );
	tempVar          = [0 , zeros(1, windowSize)];

	for i = 1:hopSize:length(audio) - windowSize
 		tempVar(2:end) = audio(i:i+windowSize-1);	
		signs          = abs(diff(sign(tempVar)));
		zeroCrossingRate(i) = mean(signs)/2;
	end
end
