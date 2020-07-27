%% Implementing Gradient Projection algorithm
function [ u ] = GradientProjectionTV( alpha, tau, i, F, proj, z )

[m,n,c] = size(F);

% Creating K
e = ones(m,1);
yDerMat = spdiags([-e e], 0:1, m, m);
yDerMat(end) = 0;
e = ones(n,1);
xDerMat = spdiags([-e e], 0:1, n, n);
xDerMat(end) = 0;
K = [kron(xDerMat',speye(n,n)); kron(speye(m,m), yDerMat)];

% Parameters of the algorithm
q = zeros(size(K,1),c);
F = reshape(F,m*n,c);

%% Gradient Projection Algorithm
for it = 1:i
    grad = K*(K'*q - F/alpha);
    q = (q - tau*grad);
    q = proj(q, z);
end


u = F - alpha*K'*q;
u = reshape(u, [m,n,c]);

end
