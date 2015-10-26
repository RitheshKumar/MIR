function reducedPkLoc=reduceDensity(peakLocation,yFreq,elimCriteria)

[rpL,cpL]=size(peakLocation);
diffFreq=diff(yFreq(peakLocation),1,2);  
NewFreq = diffFreq;
NewFreq(abs(NewFreq)<elimCriteria)=0;
NewFreq(NewFreq ~= 0)=1;
NewLocs=[NewFreq,[1;1;1;1;1;1;1;1]];
reducedPkLoc = peakLocation.*NewLocs;
% reducedPkLoc = yFreq.*NewLocs;
end

 