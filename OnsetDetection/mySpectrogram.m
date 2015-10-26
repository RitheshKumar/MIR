function [specMat,yFreq,xTime] = mySpectrogram(audio,sampleFreq,windowSize,noverlap)
    
    audio = audioMatrixToVector(audio);
    nfft=round(windowSize*noverlap*5); %window size etc. in seconds
    windowSize = round(windowSize*sampleFreq);
    noverlap = round(windowSize*sampleFreq*noverlap);
    
    [specMat,yFreq,xTime]=spectrogram(audio,windowSize,noverlap,nfft,sampleFreq);
    
    
end
