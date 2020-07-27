function [ q_out ] = Isotropic221( q, ~ )
   [m,n,~] = size(q);
   q = reshape(q, [m/2,n*2]);
   temp = sqrt(sum(q.^2,2));
   q = q./repmat(max(temp, 1), [1,size(q,2)]);
   q_out = reshape(q,[m,n]);
end

