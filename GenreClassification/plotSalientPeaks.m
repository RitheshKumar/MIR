function plotSalientPeaks(salientPeaks,xTime,yFreq,specMat)
    
     imagesc(xTime,yFreq,1-20*log10(abs(specMat))); axis xy; colormap gray;
     hold on;
%      plot(xTime,yFreq(salientPeaks),'r*','MarkerSize',2); 
    for i =1:length(salientPeaks)
        yFreqIndex = find(salientPeaks(:,i)>0);
        xTimeFix = ones(1,length(yFreqIndex));
        xTimeFix = xTimeFix.*xTime(i);
        plot(xTimeFix,yFreq(salientPeaks(yFreqIndex,i)),'r*','MarkerSize',2);
    end
end

