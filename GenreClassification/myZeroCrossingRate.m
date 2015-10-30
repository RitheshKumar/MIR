function [zeroCrossingRate] = myZeroCrossingRate( audio, windowSize, hopSize )
	
	[audio, numHops] = audioResize( audio, windowSize, hopSize );

	zeroCrossingRate = zeros(1, numHops);
% 	tempVar          = [0 , zeros(1, windowSize)];
 	tempVar          = zeros(1, windowSize);

	count = 1;

	for i = 1:hopSize:( length(audio) - windowSize + 1 )
 		tempVar        = audio(i:i+windowSize-1);	
		signs          = abs(diff(sign(tempVar)));
		zeroCrossingRate(count) = sum(signs)/(2*windowSize);
		count 	       = count + 1;
	end
end
