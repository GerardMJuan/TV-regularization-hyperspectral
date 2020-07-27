%% Random test setup with huge matrices to test runtime
n=5453;
m=7323;
u = randn(n,m);
v1 = randn(n,m);
v2 = randn(n,m);

%verification that epsi is small
tic, [ux, uy] = grad(u); toc
tic, temp = div(v1,v2); toc
epsi = abs(sum(ux(:).*v1(:)) + sum(uy(:).*v2(:))  +  sum(sum(u.*temp)))

%% other option using two sparse matrices and function handles
% matrices for x- and y-derivatives
e = ones(n,1);
yDerMat = spdiags([-e e], 0:1, n, n);
yDerMat(end) =0;
e = ones(m,1);
xDerMat = spdiags([-e e], 0:1, m, m)';
xDerMat(end)=0;

% function handles for computing derivatives
gradFunctionHandle = @(u)deal(u*xDerMat,yDerMat*u);
divFunctionHandle =@(v1,v2)-v1*xDerMat'-yDerMat'*v2;

tic, [ux, uy] = gradFunctionHandle(u); toc
tic, temp = divFunctionHandle(v1,v2); toc
epsi = abs(sum(ux(:).*v1(:)) + sum(uy(:).*v2(:))  +  sum(sum(u.*temp)))

