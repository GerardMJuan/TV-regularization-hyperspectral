 function [ q_out ] = ProjectionL1Ball( q , z )
        q = q';
    	[m,n,~] = size(q);
        
        % We sort each column
        v = sort(abs(q),1,'descend');
        w = cumsum(v,1);
        i = repmat((1:m)', [1,n]);
        P = ((v - (w - z)./i) > 0);
        % We add an extra row of ones to take care of the extreme case 
        P = cat(1,double(1-P),ones(1,n));
        [~,p] = max(P);
        p = max(1,p - 1);
        pl = p + (0:n-1)*m;
        theta = max(0,(w(pl) - z) ./ p);
        q_out = sign(q).*max(abs(q) - repmat(theta, [m,1]), 0);
        q_out = q_out';
end