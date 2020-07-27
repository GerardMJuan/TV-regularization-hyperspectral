function [ q_out ] = Proj2Inf1( q )
    [m,n,c] = size(q);
    temp = zeros(m*n/2,1,1);
    for i = 1:c
        temp = max(temp, sqrt(q(1:size(q,1)/2,1,i).^2 + q(1+size(q,1)/2:end,1,i).^2));
    end
    q_out = q./repmat(max(temp, 1), [2,1,3]);  
end

