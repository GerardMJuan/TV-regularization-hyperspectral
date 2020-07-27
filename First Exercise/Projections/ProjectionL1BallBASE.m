 function [ q_out ] = ProjectionL1BallBASE( q , z )
    [m,n] = size(q);
    for k = 1:n
        v = sort(abs(q),'descend');
        w = cumsum(v(:,k));
        i = (1:m)';
        P = ((v(:,k) - (w - z)./i) > 0);
        p = find (P,1,'last');
        theta = 1/p * (w(p) - z);
        q_out(:,k) = sign(q(:,k)).*max(abs(q(:,k)) - theta, 0);
    end
end
