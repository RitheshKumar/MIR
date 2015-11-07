% Function : plotMe 
% Input:
%   vector1, vector2: samelengths
% Output: 
%   scatterplots!

function plotMe (vector1, vector2)
   
    colourVec = ['r', 'm', 'g', 'b', 'y'];

    count = 1;
    for i = 1:100:length(vector1)
        plot( vector1 (i:i+99), vector2 (i:i+99), ['o' colourVec(count)]);
        count = count+1;
        hold on;
    end

    legend('Classical','Country','HipHop','Jazz','Metal');
    

end
