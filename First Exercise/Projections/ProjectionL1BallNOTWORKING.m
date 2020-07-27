 function [ q_out ] = ProjectionL1Ball( q , z )
    [m,n] = size(q);
    for k = 1:n
        v = sort(abs(q),'descend');
        w = cumsum(v);
        i = (1:m)';
        P = ((v - (w - z)./i) > 0);
        p = find (P,1,'last');
        theta = 1/p * (w(p) - z);
        q_out(:,k,l) = sign(q(:,k,l)).*max(abs(q(:,k,l)) - theta, 0);
    end
end
