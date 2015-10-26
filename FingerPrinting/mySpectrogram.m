function [specMat,yFreq,xTime] = mySpectrogram(audio,sampleFreq,window,noverlap)
    
    [m,n] = size(audio);
    if m>n
        if n>1
            audio = mean(audio,2);    %if columns represent channels
        end
    
    else
        audio = mean(audio);       %if rows represent channels
    end
    
    nfft=round(window*sampleFreq*noverlap*5); %window size etc. in seconds
    windowSamples = round(window*sampleFreq);
    overlapSamples = round(window*sampleFreq*noverlap);
    
    [specMat,yFreq,xTime]=spectrogram(audio,windowSamples,overlapSamples,nfft,sampleFreq);
    
    
end
