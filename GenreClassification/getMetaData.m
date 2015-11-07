%% Function: getMetaData 
% [metaData, genre] = getMetaData (windowSize, hopSize)
% input: 
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
%   datasetFolderPath: string path of your dataset location
% output: 
%   metaData: 10 by numFilesInDataset  float vector, the resulting feature matrix
%   genre:    1  by numFilesInDataset  string vector, with genre classified as numbers
%   1 - Classical   2 - Country  3 - HipHop
%   4 - Jazz        5 - Metal

function [metaData , genre ] = getMetaData ( windowSize, hopSize, datasetFolderPath)

	fileID=fopen('foldersInGenres.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
	foldersInDataset  = D{1};

% 	datasetFolderPath = '/Users/Rithesh/Documents/3rd Sem/genres/';	

	for i = 1: length ( foldersInDataset )

		%char (strcat (datasetFolderPath, foldersInDataset (i) ) ) 
		addpath (char (strcat (datasetFolderPath, foldersInDataset (i) ) ) );

	end
	
	fileID=fopen('fileNames.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 

	fileNames = D{1};
	numFiles  = length ( fileNames );
	metaData  = zeros (10, numFiles);

	for i = 1: numFiles 
	
		[ audioFile, sampleFreq ] = audioread (char (fileNames (i) ) );

		if ( mod(i-1,100) == 0 )
			disp ([ 'Extracting Features for ' , char(foldersInDataset((i+99)/100)) , ' set' ]);
		end

		metaData (: , i)          = getFeatureVector ( audioFile, sampleFreq, windowSize, hopSize );

		if ( mod (i,10) == 0 )
			disp( sprintf (' Completed %d%%', i*100/ numFiles ) ); 
		end

	end

    numGenres = length (foldersInDataset);
    genre     = 1:numGenres;
    genre     = repmat  (genre, [numFiles/numGenres,1]);
    genre     = reshape (genre, [1, numFiles] );

end
