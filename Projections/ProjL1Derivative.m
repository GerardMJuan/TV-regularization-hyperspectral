 function [ q_out ] = ProjL1Derivative( q , z )
    % q will be [n*m*2,c]
    [m,n,~] = size(q);
    q = reshape(q, [m/2,2,n]);
    for i = 1:n
        q_out(:,:,i) = ProjectionL1Ball(q(:,:,i), z);
    end
    q_out = reshape(q_out,[m,n]);
end