function [ q_out ] = IsotropicProjectionNoP( q )
    [m,n,c] = size(q);
    q_out = zeros(m,n,c);
    for i = 1:c
        temp = sqrt(q(1:size(q,1)/2,1,i).^2 + q(1+size(q,1)/2:end,1,i).^2); 
        q_out(:,:,i) = q(:,:,i)./repmat(max(temp, 1), [2,1]); 
    end
end

