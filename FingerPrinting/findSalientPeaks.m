function [salientPeaks] = findSalientPeaks(specMat, pitchDistance, percentPeaksPerFrame, sampleFreq)
     
 
    f0 = 100;
    NDiv=floor(log2(sampleFreq/2/f0)); % sampling rate is 16 kHz, considering human voice at ~200Hz, its octaves / 6 harmonics will span till 8 kHz.
    refFreq = f0*2.^(0:NDiv); % upper limit of the band :: goes till 6400
    refFreq = [0 , refFreq, sampleFreq/2];
    
    freqIndx = zeros(length(refFreq),1);

    yFreq = 0 : sampleFreq/(2*(length(specMat(:,1))-1)) : sampleFreq/2;

    for i= 1: length(refFreq)
        [~,freqIndx(i)] = min(abs(refFreq(i) - yFreq));
    end
    
    
    binDistance = pitchDistance;
    
    [~,colSpecMat] = size(specMat);
    peakLocation = zeros(length(freqIndx)-1,colSpecMat);

    for i = 1:colSpecMat
        for k = 1:length(freqIndx)-1
            [~,peakLocation(k,i)] = max(abs(specMat(freqIndx(k):freqIndx(k+1)-1,i)));
            peakLocation(k,i) = peakLocation(k,i) + freqIndx(k) -1;
        end
    end

    salientPeaks = peakLocation;
    
end
