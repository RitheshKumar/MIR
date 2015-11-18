%% compute self-distance matrix
% input:
%   featureMatrix: numFeatures by numSamples float matrix, feature matrix
% output:
%   SDM: numSamples by numSamples float matrix, self-distance matrix

function SDM = computeSelfDistMat(featureMatrix)

% SDM = pdist2(featureMatrix,featureMatrix);

[numFeatures,numSamples]=size(featureMatrix);
SDM=zeros(numSamples,numSamples);

for i = 1: numSamples
    for j=1:numSamples
        SDM(i,j)=sum((featureMatrix(:,i)-featureMatrix(:,j)).^2).^0.5;
    end
end

end