function [vpc] = FeatureSpectralPitchChroma(X, f_s)


% octave range 4 Octaves starting at C4
% tuning frequency 440Hz
% sum of each semitone band
% normalize the pitch chroma to a sum of one

win=4*f_s;
p=0:(win/2)-1;
h=p*(1/((win/2)-1))*(f_s/2); % bin numbers converted to Hz

f_binsMidi=69+12*log2(h/440);
locmin=69;
locmax=69+(12*4)-1;

midiBins = round(f_binsMidi);
f_binsMidiNew=midiBins(midiBins>=locmin & midiBins<locmax);
Xnew = X(find(midiBins>=locmin & midiBins<locmax),:);
ChromaBins=mod(f_binsMidiNew,12);

[Xrw,Xcol]=size(Xnew);
for j=1:Xcol
for i=1:max(ChromaBins)+1
    ChromaAmpl(i,j)=sum(Xnew(ChromaBins==i-1,j));
end
    if sum(ChromaAmpl(:,j))~=0
        ChromaAmpl(:,j)=ChromaAmpl(:,j)./sum(ChromaAmpl(:,j));
    end
end
vpc=ChromaAmpl;

end