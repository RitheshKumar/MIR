function [metaData , genre ] = getMetaData ()
	
	addpath( '../../genres/' );

	fileID=fopen('list of groundtruth.txt'); 
	D = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
	fileID=fopen('list of audiofiles.txt');
	C = textscan(fileID,'%s','Delimiter', '\n', 'CollectOutput', true); 
	stringsgt=D{1};
	stringsau=C{1};
	gtstring='/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/groundtruth_renamed/';
	austring='/Users/ritheshkumar/Documents/Alexander/TechLab/drummer_3/audio/dry_mix/';

	for ik=1:length(stringsgt)

	fileID_i=fopen(char(strcat(gtstring,stringsgt(ik)))); 
	[X,Fs]= audioread(char(strcat(austring,stringsau(ik)))); 
