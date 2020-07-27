function [ q_out ] = AnisotropicProjectionNoP( q )
    q_out = sign(q).*min(abs(q),1);
end

