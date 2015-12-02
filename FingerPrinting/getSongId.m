function songId = getSongId ( H )

%   getSongId from the input hashes
%   H is hashStruct < songId tOffset hash > >>here songId is 0 for unknown

global hashTable hashCount

songInMin = 8.5;                                           %We assume that the song is of max length 8 mins 30 secs
songLen   = ( 60*songInMin - 0.064 ) / 0.032 ;

inputHashes = H( :, 3);
inputHashes = unique( inputHashes );
numHashes   = length( inputHashes );
idCnt       = 0;

for i = 1: numHashes

    currentHash = inputHashes( i );
    hashEntries = hashCount( currentHash );
    idVec       = hashTable( 1:hashEntries, currentHash ); % store the list of entries
                                                           % for currentHash

    idCnt       =  idCnt + 1;
    idExtrct( idCnt : idCnt+hashEntries-1 ) = floor( idVec./songLen );

end

[occ, ids]      = hist( idExtrct, unique(idExtrct) );
[~, mxOccId ]   = max(occ);
songId          = ids( mxOccId ); 

end
