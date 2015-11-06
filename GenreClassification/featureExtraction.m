%% Function: featureExtraction 
%  featureExtraction (windowSize, hopSize)
% input: 
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   plots, visualization

function featureExtraction( )

	[metaData , genre ] = getMetaData ( windowSize, hopSize);
	%load ( 'metaData.mat' );

	numFiles    = length ( metaData (1,:) );
	numFeatures = length ( metaData (:,1) );
	
	zScoreData  = zeros ( size (metaData) );

	% z-score evaluation
	for i = 1 : numFeatures 

		zScoreData(i,:) = ( metaData(i,:) - mean( metaData(i,:) ) )./std( metaData(i,:) );

	end

	% finding Covariance Matrix	
	covMat  =  zeros ( numFeatures , numFeatures );

	for jj = 1 : numFeatures

		for kk = 1 : numFeatures

			covMat (jj,kk) = sum ( zScoreData (jj,:) .* zScoreData (kk,:) ) / (numFiles - 1);

		end

	end
end

	


