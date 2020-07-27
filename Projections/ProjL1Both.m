 function [ q_out ] = ProjL1Both( q , z )
    % q will be [n*m*2,c]
    [m,n,~] = size(q);
    q = reshape(q, [m/2,2*n]);
    q_out = ProjectionL1Ball(q,z);
    q_out = reshape(q_out, [m,n]);
end