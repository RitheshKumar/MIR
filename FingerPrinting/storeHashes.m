function storeHashes( H )

%   H is hashStruct < songId tOffset hash >

global hashTable hashCount

numHashes = length( H( :, 1 ) );

songInMin = 12;                %the longest song in the dataset is 11:40
songLen   = ( 60*songInMin - 0.064 ) / 0.032 ; %timeFrames per song

for i = 1 : numHashes

    hash       = H( i, 3 );
    tOffset    = H( i, 2 );
    songId     = H( i, 1 );
    tableEntry = songId*songLen + tOffset;

    numEntries = hashCount( H( i, 3) );
    numEntries = numEntries+1;

    if ( numEntries ~= 20 )
        hashTable( numEntries, hash )  = tableEntry;

    else
        enterInto                      = floor( rand*9 ) + 1;
        hashTable( enterInto, hash )   = tableEntry;
    end

    hashCount( hash ) = numEntries;

end

end

    
