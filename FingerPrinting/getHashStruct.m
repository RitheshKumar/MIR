function H = getHashStruct( songId, L )

%   H, hashStruct < songId, tOffset, hash >
%   L, LandMarks  < startTime, startFreq, endFreq, deltaTime > 

    numLndMrks = length( L( :, 1 ) );
    H = zeros( numLndMrks, 3 );


    for i = 1:numLndMrks

        H( i, 1 ) = songId;
        H( i, 2 ) = L(i, 1);  % start-time/timeOffset

        % encode Hash
        delF      = L(i, 3) - L(i, 2) + 31; %endFreq - startFreq + 31 [0,63]
        delT      = L(i, 4);      % deltaTime
        f1        = L(i, 2) - 1;  % startFreq/f1
                                  % change range of startFreq from 0 to 255
        H( i, 3 ) = delT + delF*2^6 + f1*2^12;

    end

end


