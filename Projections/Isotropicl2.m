function [ q_out ] = Isotropicl2( q, ~ )
   [m,n,~] = size(q);
   q = reshape(q, [m/2,2,n]);
   temp = sqrt(sum(q.^2,2));
   q = q./repmat(max(temp, 1), [1,size(q,2)]);
   q_out = reshape(q,[m,n]);
end

