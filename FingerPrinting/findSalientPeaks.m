function [salientPeaks] = findSalientPeaks(specMat,pitchDistance,percentPeaksPerFrame,yFreq)
     
 
    NDiv=6; % sampling rate is 16 kHz, considering human voice at ~200Hz, its octaves / 6 harmonics will span till 8 kHz.
    f0 = 100;
    refFreq = f0*2.^(0:NDiv); % upper limit of the band :: goes till 6400
    refFreq = [0 , refFreq, 8000];
    
    freqIndx = zeros(length(refFreq));
    for i= 1: length(refFreq)
        [~,freqIndx(i)] = min(abs(refFreq(i) - yFreq));
    end
    
    
    binDistance = pitchDistance;
%     sampleDistance = timeDistance;
    
    [~,colSpecMat] = size(specMat);
    peakLocation = zeros(length(freqIndx)-1,colSpecMat);

    for i = 1:colSpecMat
        for k = 1:length(freqIndx)-1
            [~,peakLocation(k,i)] = max(abs(specMat(freqIndx(k):freqIndx(k+1)-1,i)));
            peakLocation(k,i) = peakLocation(k,i) + freqIndx(k) -1;
        end
    end

    %nBins=length(peakLocations(:,1));
    salientPeaks = peakLocation;
    %salientPeaks = peakLocation;
    
end
