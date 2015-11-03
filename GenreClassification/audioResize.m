% This function, converts an audio matrix into a vector
% and then does zero padding so as to make the 
% blocks into absolute multiples.

function [resizedAudio,numHops] = audioResize ( audio, windowSize, hopSize )
	
	audio = audioMatrixToVector(audio);   %now our audio is a Row Vector

        % Make the length of the audio to become a whole size
        %   numHops*hopSize + windowSize = length(audio) : if numHops is a whole no. 
        %   Therefore, adjust the length such that numHops is a whole no.
        audioLen = length(audio);
        numHops = ceil((audioLen - windowSize)/hopSize);
        newAudioLen = numHops*hopSize + windowSize;
        resizedAudio = [audio, zeros(1,newAudioLen-audioLen)];

end
