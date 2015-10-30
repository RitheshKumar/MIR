%% Novelty function: peak envelope
% [peakEnvelope] = myPeakEnv(audio, w, windowSize, hopSize)
% input: 
%   audio: N by 1 float vector, input signal
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   peakEnvelope: n by 1 float vector, the resulting novelty function 

function [peakEnvelope] = myPeakEnv(audio, windowSize, hopSize)

	[audio, numHops] = audioResize( audio, windowSize, hopSize ); 
	envlp = zeros(numHops,1);
	count=1;

	for i = 1:hopSize:( length(audio) - windowSize  )
		envlp(count) = max(abs(audio(i:i+windowSize)));
		count=count+1;
	end

	peakEnvelope=diff(envlp);
	peakEnvelope(peakEnvelope<0) = 0;  %HWR

	if sum(peakEnvelope)~=0
		peakEnvelope = peakEnvelope./max(peakEnvelope);
	end

end
