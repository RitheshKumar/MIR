function [salientPeaks] = findSalientPeaks2(specMat,timeDistance,pitchDistance,percentPeaksPerFrame,yFreq)
     
 
    NDiv=5; % sampling rate is 22050Hz, considering human voice at ~200Hz, its octaves / 5 harmonics will span till 10000Hz.
    f0 = 100;
    refFreq = f0*2.^(0:7); 
    refFreq = [0 , refFreq];
    
    for i= 1: length(refFreq)
        [~,freqIndx(i)] = min(abs(refFreq(i) - yFreq));
    end

    
    binDistance = pitchDistance;
    sampleDistance = timeDistance;
    [~,peakLocations] = sort(abs(specMat(1:binDistance:end,1:sampleDistance:end)),'descend');
%     [~,peakLocations] = sort(abs(specMat(:,1:sampleDistance:end)),'descend');
    nBins=length(peakLocations(:,1));
    topVals=round(nBins*percentPeaksPerFrame);
    salientPeaks=peakLocations(1:topVals,:);
    
end
