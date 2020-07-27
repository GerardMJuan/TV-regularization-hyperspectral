function [ q_out ] = Projection221( q )
    [m,n,c] = size(q);
    temp = zeros(m*n/2,1,1);
    for i = 1:c
        temp = temp + q(1:size(q,1)/2,1,i).^2 + q(1+size(q,1)/2:end,1,i).^2;
    end
    temp = sqrt(temp);
    q_out = q./repmat(max(temp, 1), [2,1,3]);  
end

