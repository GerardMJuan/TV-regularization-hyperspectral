function [ q_out ] = Anisotropicl111( q, ~ )
 q_out = max(min(q, 1),-1);
end

