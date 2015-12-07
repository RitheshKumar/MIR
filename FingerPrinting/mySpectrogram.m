function [specMat,yFreq,xTime] = mySpectrogram(audio,sampleFreq,window,noverlap)
% specMat - spectrogram matrix
% yFreq   - freq values at bins
% xTime   - time values at frames in seconds
% window  - window size in seconds
% noverlap- overlap from 0 to 1 
    
    [m,n] = size(audio);
    if m>n
        if n>1
            audio = mean(audio,2);    %if columns represent channels
        end
    
    else
        audio = mean(audio);          %if rows represent channels
    end
    
    nfft=round(window*sampleFreq*noverlap*2); %window size etc. in seconds
    windowSamples = round(window*sampleFreq);
    overlapSamples = round(window*sampleFreq*noverlap);
    
    [specMat,yFreq,xTime]=spectrogram(audio,windowSamples,overlapSamples,nfft,sampleFreq);
    
    
end
