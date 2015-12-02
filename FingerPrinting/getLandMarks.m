function [L,maxBck] = getLandMarks( specMat )
    
    numBins = length( specMat( :, 1 ) );         % num Time Frames
    numFrms = length( specMat( 1, : ) );         % num Freq Bins  

    specMat = abs( specMat );                    
    specMax = max( specMat(:) );                 % max every time Frame
    specMat = log( max(specMax/1e6, specMat ) ); % >> us
    specMat = specMat - mean( specMat(:) );      % make zero mean

    specMat = (filter([1 -1],[1 -0.98],specMat')'); %hpf 

    sprd    = 30;                           % spread of the gaussian window
    hashesPerSec = 5;
    gausDec = 1 - 0.01*(hashesPerSec/35);   % relates to hashes per sec
    thresh  = thresholdCalc( max( specMat ( :, 1:10), []  , 2 ), sprd );
    
    %L = thresh;
    %Y = spread( max( specMat ( :, 1:10), []  , 2 ), sprd );

    pksPerFrame = 5;
    pksFnd      = 0;
    maxFwd      = zeros( 3, numFrms*2 );
    maxCnt      = 1;

    for i = 1:numFrms

        %threshold
        curFrame = specMat( :, i )';
        curFrame( curFrame<=thresh ) = 0; 

        %findLocal Maxima
        [~, peakLoc]     = findpeaks( [ 0, curFrame] ); % incase first element is maxima
        peakLoc          = peakLoc - 1;

        %get Local Maxima with descending order indices
        peakVec          = curFrame*0;
        peakVec(peakLoc) = curFrame(peakLoc);
        [~, peakIdx]     = sort( peakVec, 'descend');
        peakIdx(peakVec(peakIdx)==0) = [];
        

        for ii =  peakIdx  
            if ( peakVec( ii ) > thresh( ii ) && pksFnd < pksPerFrame )
                maxFwd ( 1, maxCnt ) = i;             % Time Frame Indx
                maxFwd ( 2, maxCnt ) = ii;            % Bin Indx
                maxFwd ( 3, maxCnt ) = peakVec( ii ); % Magnitude
            
                %recalculate thresh >>why not use the same thing in thresholdCalc?
                gausn  = exp( -0.5 * ( ( ( 1:length(thresh) ) - ii ) / sprd ).^2 );  %Gaussian with mean centred  
                                                                                     %around current peakIdx
                thresh = max( thresh, gausn*peakVec( ii ) );

                %update counts
                maxCnt = maxCnt + 1;
                pksFnd = pksFnd + 1;
            end
        end
        thresh = gausDec*thresh;
        pksFnd = 0;
    end
    
    maxIdx = maxCnt - 1;
    maxBck = zeros( 2, maxIdx );
    bckCnt = 1; 
    %thresh  = thresholdCalc( max( specMat ( :, numFrames:-1:numFrames-9), []  , 2 ), sprd ); % Calc threshold from last 10 frames
    thresh = thresholdCalc( specMat( :, numFrms ) , sprd ); %% >> check thresholdCalc!! This is the last bug spot! <<>> c'est bien! 

    for i = numFrms:-1:1
    
        while ( maxIdx > 0  && maxFwd( 1, maxIdx ) == i )    % >> while condition loops for all the maxFwds that were found
            if  ( maxFwd(3, maxIdx) >= thresh( maxFwd(2, maxIdx ) ) )
                maxBck( 1, bckCnt) = i;                      % TimeFrame
                maxBck( 2, bckCnt) = maxFwd(2, maxIdx);      % FrequencyBin
                bckCnt  = bckCnt + 1;

                % recalculate threshold
                gausn  = exp( -0.5 * ( ( ( 1:length(thresh) ) - maxFwd( 2,maxIdx ) ) / sprd ).^2 );
                thresh = max( thresh, gausn*maxFwd(3, maxIdx) ); 
            end
            maxIdx = maxIdx - 1;
        end
        thresh = gausDec*thresh;
    end

    maxBck = fliplr(maxBck(:,1:bckCnt-1));


    % Find LandMarks
    prsPerPk = 3;
    delTime  = 63;
    delFreq  = -31;

    landCnt = 0;
    L       = zeros( 2*bckCnt, 4 );

    for i = 1:( bckCnt - 1 )
        minF = maxBck(2, i) + delFreq;
        maxF = minF + 63;

        strT = maxBck(1, i) ;
        finT = strT + delTime;
        
        matchLocs  = find( maxBck(1,:) > strT & maxBck(1,:) <= finT & maxBck(2,:) >= minF & maxBck(2,:) <= maxF );

        if length(matchLocs) > prsPerPk
            matchLocs = matchLocs(1:prsPerPk);
        end
     

        for ii = matchLocs
            landCnt = landCnt + 1;

            L(landCnt, 1) = strT;
            L(landCnt, 2) = maxBck( 2, i );   % >> should i store maxBck(2, i) in a var?
            L(landCnt, 3) = maxBck( 2, ii );
            L(landCnt, 4) = maxBck(1, ii ) - strT; % startTime
        end
    end
    
    L = L( 1:landCnt, : );

end

function thresh = thresholdCalc( vect, spread )
   
    x        = 4*spread;
    gaussian = exp( -0.5 * ( (-x:x) / spread ).^2 );

    [~, peakLoc]     = findpeaks( [ 0; vect] ); % incase first element is maxima
    peakLoc          = peakLoc - 1;
    thresh           = vect*0; 
    iterVec          = thresh';
    iterVec(peakLoc) = vect( peakLoc );

    gaussCentre      = floor( length(gaussian)/2 ) + 1;
    vecLen           = length(vect);
    totLen           = vecLen + length( gaussian );

    for i = find( iterVec > 0 )
        T         = [ zeros(1,i), gaussian];
        T(totLen) = 0;
        T         = T( gaussCentre + (1:vecLen) )';
        thresh    = max( thresh, vect(i)*T );
    end
    thresh = thresh';
end
