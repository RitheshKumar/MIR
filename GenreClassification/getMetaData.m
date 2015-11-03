%% Function: getMetaData 
% [metaData, genre] = getMetaData (windowSize, hopSize)
% input: 
%   windowSize: int, number of samples per block
%   hopSize: int, number of samples per hop
% output: 
%   metaData: 10 by numFilesInDataset  float vector, the resulting feature matrix
%   genre:    1  by numFilesInDataset  string vector, with genre classification

function [metaData , genre ] = getMetaData ( windowSize, hopSize)

	fileID=fopen('foldersInGenres.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
	foldersInDataset  = D{1};

	datasetFolderPath = '/Users/Rithesh/Documents/3rd Sem/genres/';	

	for i = 1: length ( foldersInDataset )

		%char (strcat (datasetFolderPath, foldersInDataset (i) ) ) 
		addpath (char (strcat (datasetFolderPath, foldersInDataset (i) ) ) );

	end
	
	fileID=fopen('fileNames.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 

	fileNames = D{1};
	numFiles  = length ( fileNames );
	metaData  = zeros (10, numFiles);
	genre     = zeros (1 , numFiles);

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

end
