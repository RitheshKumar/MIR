%% compute self-distance matrix
% input:
%   featureMatrix: numFeatures by numSamples float matrix, feature matrix
% output:
%   SDM: numSamples by numSamples float matrix, self-distance matrix

function SDM = computeSelfDistMat(featureMatrix)

SDM = pdist2(featureMatrix,featureMatrix);

end