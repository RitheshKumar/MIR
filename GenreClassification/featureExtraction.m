%% Function:  featureExtraction 
%  [zScoreData, genre] = featureExtraction (windowSize, hopSize)
% input: 
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   plots, visualization
%   zScoreData: z-score normalized metaData 
%   genre:      their corresponding genre labels
%   covMat:     covariance Matrix

function [zScoreData, genre, covMat] = featureExtraction(windowSize, hopSize)

%  	[metaData , genre ] = getMetaData ( windowSize, hopSize);
	load ( 'metaData.mat' );
    genre     = 1:5;
    genre     = repmat  (genre, [500/5,1]);
    genre     = reshape (genre, [1, 500] );

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

	


