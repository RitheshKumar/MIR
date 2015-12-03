%%

addpath('/Users/Rithesh/Documents/3rd Sem/DataSet/FingerprintingData/');

fileID=fopen('fileNames.txt'); 
D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
load ('hashTable.mat'); load('hashCount.mat');
fileNames = D{1};

sampleFreq = 8000; %not giving importance to High Frequency Content
windowSize = 0.064; noverlap = 0.5;


%% evaluate
% numFiles = length( fileNames );
% songId = zeros( numFiles, 1 );
%     for i = 1:numFiles

%         [ audio, oldSampleFreq ] = audioread (char (fileNames (i) ) );  % songID = 4
        [ audio, oldSampleFreq ] = audioread ('~/Downloads/sunshineStevieTest.wav');
        audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

        [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

        [L,~]  = getLandMarks( specMat );   
        H      = getHashStruct( 0, L );

%         songId(i) = getSongId( H );
        songId = getSongId( H )

%         fprintf('Stored songId for %d\n', i ); 
 
%     end

%     save( 'songId.mat', 'songId');
