%% Standard evaluation metrics 
% [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)
% intput:
%   onsetTimeInSec: n by 1 float vector, detected onset time in second
%   annotation: m by 1 float vector, annotated onset time in second
%   deltaTime: float, maximum time difference for a true positive (millisecond) 
% output:
%   precision: float, fraction of TP from all detected onsets
%   recall: float, fraction of TP from all reference onsets
%   fmeasure: float, the combination of precision and recall

function [precision, recall, fmeasure] = evaluateOnsets(onsetTimeInSec, annotation, deltaTime)

% YOUR CODE HERE: 
tp=0;
fp=0;
fn=0;
deltaTime=deltaTime*0.001;
for lp=1:length(annotation)
    [~,loc]=min(abs(onsetTimeInSec-annotation(lp)));
    if abs(onsetTimeInSec(loc)-annotation(lp))<=deltaTime
        annotation(lp)=0;
        onsetTimeInSec(loc)=0;
%         orig=orig(orig~=0);
        onsetTimeInSec=onsetTimeInSec(onsetTimeInSec~=0);
        tp=tp+1;
    elseif abs(onsetTimeInSec(loc)-annotation(lp))>deltaTime
        annotation(lp)=Inf;
%         orig=orig(orig~=0);
        fn=fn+1;
    end
end
if isempty(onsetTimeInSec)~=1 && isempty(annotation)~=1
    fp=length(onsetTimeInSec);
    precision=tp/(tp+fp);
    recall=tp/(tp+fn);
    fmeasure=(2*precision*recall)/(precision+recall);
    if precision==0 && recall==0
        fmeasure=0;
    end
else
    precision=0;
    recall=0;
    fmeasure=0;
end
end