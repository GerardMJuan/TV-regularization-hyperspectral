%% Implementing Gradient Projection algorithm Anisotropic

function [ u ] = GradientProjectionTV( alpha, tau, i, F, proj, )

[m,n] = size(F);

% Creating K
e = ones(m,1);
yDerMat = spdiags([-e e], 0:1, m, m);
yDerMat(end) = 0;
e = ones(n,1);
xDerMat = spdiags([-e e], 0:1, n, n);
xDerMat(end) = 0;
K = [kron(xDerMat',speye(n,n)); kron(speye(m,m), yDerMat)];

% Parameters of the algorithm
u = F;
q = zeros(size(K,1),1);
F = F(:);


%% Gradient Projection Algorithm Anisotropic
for k = 1:i
    grad = K*(K'*q - F/alpha);
    q = (q - tau*grad);
    q = proj(q);
end
    u = reshape(F - alpha*K'*q, [n,m]);

end
