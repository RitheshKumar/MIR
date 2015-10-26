function [audioVector] = audioMatrixToVector(audioMatrix)

    [m,n] = size(audioMatrix);
    if m>n
        if n>1
            audioVector = mean(audioMatrix,2);    %if columns represent channels
            audioVector = audioVector';           %we wish to make it a row vector 
        elseif n==1
            audioVector = audioMatrix;
        end
    
    else %if m<n    we assume that m~=n
        if m>1
           audioVector = mean(audioMatrix);       %if rows represent channels
        elseif n==1
            audioVector = audioMatrix;
        end
    end
    
end

