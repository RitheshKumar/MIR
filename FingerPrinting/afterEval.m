%%
addpath('/Users/Rithesh/Documents/MIR/Projects/FingerPrinting_Supplies/FingerprintingData/trainSet/');

fileID=fopen('fileNames.txt'); 
D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
load ('hashTable.mat'); load('hashCount.mat');
fileNames = D{1};

%%
sampleFreq = 8000; %not giving importance to High Frequency Content
windowSize = 0.064; noverlap = 0.5;


%% evaluate all
numFiles = length( fileNames );
songId = zeros( numFiles, 1 );
    for i = 1:numFiles

        [ audio, oldSampleFreq ] = audioread (char (fileNames (i) ) );  
%         [ audio, oldSampleFreq ] = audioread ('~/Desktop/enterSandManTest.wav');
        audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

        [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

        [L,~]  = getLandMarks( specMat );   
        H      = getHashStruct( 0, L );

        songId(i) = getSongId( H );
%         songId = getSongId( H )

        fprintf('Stored songId for %d\n', i ); 
 
    end

%     save( 'songId.mat', 'songId');

%% evaluate tests
addpath('/Users/Rithesh/Documents/MIR/Projects/FingerPrinting_Supplies/FingerprintingData/testExcerpts/');

fileID=fopen('testFiles.txt'); 
D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
load ('hashTable.mat'); load('hashCount.mat');
testFiles = D{1};

numTestFiles = length( testFiles );

for i = 1:numTestFiles

        [ audio, oldSampleFreq ] = audioread (char (testFiles (i) ) );  
        audio = resample(audio,sampleFreq,oldSampleFreq);  %downsample to 8000Hz

        [specMat,~,~] = mySpectrogram(audio,sampleFreq,windowSize,noverlap);

        [L,~]  = getLandMarks( specMat );   
        H      = getHashStruct( 0, L );

        disp(testFiles(i));
        songId = getSongId( H )
end
 
