function [ q_out ] = IsotropicProjection2D( q )
    q_out = sign(q).*min(abs(q),1);
end

