function L = getLandMarks( specMat )
    
    specMat = abs( specMat );                    
    specMax = max( specMat(:) );                 % max every time Frame
    specMat = log( max(specMax/1e6, specMat ) ); % >> us
    specMat = specMat - mean( specMat(:) );      % make zero mean

    specMat = (filter([1 -1],[1 -0.98],specMat')'); %hpf 

    sprd = 30; % spread of the gaussian window
    thresh = thresholdCalc( max( specMat ( :, 1:10), []  , 2 ), sprd );
    L      = thresh;


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
        T         = T( gaussCentre+1 : gaussCentre + vecLen )';
        thresh    = max( thresh, vect(i)*T );
    end
    thresh = thresh';
end
