function songId = getSongId ( H )

%   getSongId from the input hashes
%   H is hashStruct < songId tOffset hash > >>here songId is 0 for unknown
%   songId - 2 columns matrix <songId  confidenceMatchInPercentage>

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
occ             = (occ.*100)./sum(occ);                    % converting to percentage
songId          = [ids; occ];


%if we want first 10 matches
if isempty(songId)~=1

    [ ~ , ord]  = sort( songId(2,:), 'descend' );
    songId      = songId( :, ord );

    if length(songId(1,:)) > 10
        songId  = songId(:,1:10)';
    else
        songId  = songId';
    end

else
    songID      = [0 0];                                    % return zero if there are no matches at all
end

% % if we want just first match
% [~, mxOccId ]   = max(occ);
% songId          = ids( mxOccId ); 

end
