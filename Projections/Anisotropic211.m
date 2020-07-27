function [ q_out ] = Anisotropic211( q, ~ )
    temp = sqrt(sum(q.^2,2));
    q_out = q./repmat(max(temp, 1), [1,size(q,2)]);
end

