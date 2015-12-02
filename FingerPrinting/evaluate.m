function evaluate ()
 
    addpath('/Users/Rithesh/Documents/MIR/Projects/FingerPrinting_Supplies/DanEllisCodes/audio/');
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
        
        if mod (i,10) == 0
			fprintf (' Completed %d%%', i*100/ numFiles ) ; 
		end

    end


    %% evaluate
    [ audio, oldSampleFreq ] = audioread (char (fileNames (20) ) );  % songID = 4

    audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

    [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

    [L,~]  = getLandMarks( specMat );   
    H      = getHashStruct( i, L );

    songId = getSongId( H )
%     disp(songId);

end

