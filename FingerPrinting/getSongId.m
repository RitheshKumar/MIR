function songId = getSongId ( H )

%   getSongId from the input hashes
%   H is hashStruct < songId tOffset hash > >>here songId is 0 for unknown

global hashTable hashCount

songInMin = 12;                                           %Longest track in dataset is 11:40
songLen   = ( 60*songInMin - 0.064 ) / 0.032 ;

inputHashes = H( :, 3);
inputHashes = unique( inputHashes );
numHashes   = length( inputHashes );
idExtrct    = [];

for i = 1: numHashes

    currentHash = inputHashes( i );
    hashEntries = hashCount( currentHash );
    idVec       = hashTable( 1:hashEntries, currentHash ); % store the list of entries
                                                           % for currentHash

    idExtrct    = [idExtrct , floor( idVec./songLen )' ]; 

end

[occ, ids]      = hist( idExtrct, unique(idExtrct) );
[~, mxOccId ]   = max(occ);
songId          = ids( mxOccId ); 

end
