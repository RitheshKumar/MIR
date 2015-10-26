function blot(timeEst,annotation)
if length(annotation)>length(timeEst)
    plot(timeEst,annotation(1:length(timeEst)));
else 
    plot(timeEst(1:length(annotation)),annotation);
end
end