function evaluate ()
 
    %% build hashTable

    addpath('/Users/Rithesh/Documents/3rd Sem/DataSet/FingerprintingData/');

    fileID=fopen('fileNames.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 

	fileNames = D{1};
	numFiles  = length ( fileNames );


    global hashTable hashCount
    hashTable = zeros( 20, 2^20); % maximum 20 entries per hash
    hashCount = zeros( 1,  2^20); % 2^20 cause our hash is a 20 bit structure

    sampleFreq = 8000; %not giving importance to High Frequency Content
    windowSize = 0.064; noverlap = 0.5;

    for i = 1:numFiles

        [ audio, oldSampleFreq ] = audioread (char (fileNames (i) ) );

        audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

        [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

        [L,~]  = getLandMarks( specMat );   
        H      = getHashStruct( i, L );
        storeHashes( H );

        fprintf(' Stored %s\n', char( fileNames(i) ) );

    end

    % The following line have been commented out just so hashTable.mat & hashCount.mat are not rewritten 
    %save( 'hashTable.mat', 'hashTable' );
    %save( 'hashCount.mat', 'hashCount' );


    %% evaluate
    
    songId = zeros( numFiles, 1 );
    for i = 1:numFiles

        [ audio, oldSampleFreq ] = audioread (char (fileNames (i) ) ); 

        audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

        [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

        [L,~]  = getLandMarks( specMat );   
        H      = getHashStruct( 0, L );

        matches   = getSongId( H );  % return the top 10 match along with percentage match
        songId(i) = matches(1,1);    % we are storing only the song id of the first match

        fprintf('Stored songId for %d\n', i );

    end

    save( 'songId.mat', 'songId');


end

