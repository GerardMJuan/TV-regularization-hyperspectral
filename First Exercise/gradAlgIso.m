%% Implementing Gradient Projection algorithm isotropic

% What does Isotropic means?

% What does Anisotropic means?

% What is the fucking K
img = im2double(imread('lena.bmp'));
[m,n] = size(img);

e = ones(m,1);
yDerMat = spdiags([-e e], 0:1, m, m);
yDerMat(end) = 0;

e = ones(n,1);
xDerMat = spdiags([-e e], 0:1, n, n);
xDerMat(end) = 0;

% function handles for computing derivatives
gradFunctionHandle = @(u)deal(u*xDerMat,yDerMat*u);
divFunctionHandle =@(v1,v2)-v1*xDerMat'-yDerMat'*v2;

[xDer,yDer] = gradFunctionHandle(img);

K2 = [kron(xDerMat',speye(n,n)); kron(speye(m,m), yDerMat)];

imgGradient = gradM * img(:);

figure, imagesc(reshape(imgGradient(1:n*m),[n,m])), colorbar

% Parameters of the algorithm
alpha = 0.1;
tau = 0.2;
sigma = 0.01;
F = imnoise(img,'gaussian',0,sigma);

u = F;
q = zeros(size(K,1),1);
F = F(:);
%% Gradient Projection Algorithm
for k = 1:100
    grad = K*(K'*q - F/alpha);
    q = (q - tau*grad);
    q = max(min(q,1),
    
    [xDer,yDer] = gradFunctionHandle(u);
    div = -divFunctionHandle(xDer,yDer);
    [xDer2,yDer2] = gradFunctionHandle(div - (F/alpha));
    q1 = sign(q - tau .* (norm(xDer2,1) + norm(yDer2,1))) .* min(abs(q - tau .* (norm(xDer2,1) + norm(yDer2,1))),1);
    u = F - alpha*q1;
    q = q1;
end

% Output
figure;
subplot(1,3,1);
imshow(img);
title('Original image');

subplot(1,3,2);
imshow(F);
title('Noised image');

subplot(1,3,3);
imshow(u);
title('Deblurred Image');
