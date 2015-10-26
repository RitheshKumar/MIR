%% Evaluate the results
% [err_rms] = myEvaluation(est, ann)
% Input:
%   estimation = numBlocks*1 float vector, estimated pitch (Hz) per block   
%   annotation = numBlocks*1 float vector, annotated pitch (Hz) per block
% Output:
%   errCent_rms = float, rms of the difference between estInMidi and annInMidi 
%                 Note: please exclude the blocks when ann(i) == 0
% CW @ GTCMT 2015

function [errCent_rms] = myEvaluation(estimation, annotation)

% Please write your code here

%annot_cents= 69 + (12*log2(annotation(annotation~=0)/440));
%est_cents= 69 + (12*log2(estimation(annotation~=0)/440));
 annot_cents= 1200*log2(annotation(annotation~=0)/440);
 est_cents= 1200*log2(estimation(annotation~=0)/440);
est_cents(abs(est_cents)==inf)=0;

errCent_rms=sqrt(mean((annot_cents-est_cents).^2));
