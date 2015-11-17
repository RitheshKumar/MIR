%% compute novelty function from Self-distance matrix
% input:
%   SDM: float N by N matrix, self-distance matrix
%   L: int, size of the checkerboard kernel (L by L) preferably power of 2
% output:
%   nvt: float N by 1 vector, audio segmentation novelty function 

function [nvt] = computeSdmNovelty(SDM, L)


posMat = ones(L/2,L/2);
negMat = -posMat;

kern1 = horzcat(posMat, negMat);
kern2 = horzcat(negMat, posMat);

kernel = vertcat(kern1, kern2);

win = fspecial('gaussian',size(kernel),4);
win = win ./ max(win(:));
kernel=kernel.*win;

%matlab 2009 doesnt have pdist2 so comment the line32 of pdist2 and
%uncomment the 2lines below
% sim_mat=pdist(feature,dist_measure);
% sim_mat=squareform(sim_mat);

nov_score=zeros(length(SDM),1);

%  kernel multiplication along diagonal to obtain the novelty score
for i=L/2:length(SDM)-L/2
       
    for k1=-L/2:L/2-1
        for k2=-L/2:L/2-1
            temp_chk(k1+L/2+1,k2+L/2+1)= SDM(i+k1+1,i+k2+1);
        end
    end
    nov_score(i)=sum(sum(temp_chk.*kernel));
end
nvt=abs(nov_score);

end