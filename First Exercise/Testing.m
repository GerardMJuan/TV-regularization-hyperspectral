% Implementing a variational method in MATLAB for image smoothing
% Gerard Mart� Juan

clc; clear all;
%close all;
% We will use lena512 as a sample image
lena512 = imread('lena.bmp');

% sigma, we need them to be <= 1/8
sigma = 0.01;

% We add gaussian noise to the image
F = imnoise(lena512,'gaussian',0,sigma);
F = im2double(F);
[m,n] = size(F);
% We create our initial image guess
% Grad and div
e = ones(n,1);
yDerMat = spdiags([-e e], 0:1, n, n);
yDerMat(end) =0;
e = ones(m,1);
xDerMat = spdiags([-e e], 0:1, m, m)';
xDerMat(end)=0;

% function handles for computing derivatives
gradFunctionHandle = @(u)deal(u*xDerMat,yDerMat*u);
divFunctionHandle =@(v1,v2)-v1*xDerMat'-yDerMat'*v2;

K = [kron(xDerMat',speye(n,n)); kron(speye(m,m), yDerMat)];

%% Initiating algorithm %%

% Lambda parameter for regularization
lambda = 8;
tau = 0.05;
sigma = 1 / 8 / tau;
% Initial parameters
Yn = zeros(size(K,1),1);
F = F(:);
Un = F;

% Starting loop 
% Finish condition: number of iterations (better way?)
figure
for i = 1:200
    UnOld = Un;
    Un = (tau*lambda*F - tau*K'*Yn + Un)/(1+lambda*tau);
    % Un = (F - K'*Yn + Un/(lambda*tau)) / (1 + 1/(lambda*tau)); 
    Uln_bar = 2*Un - UnOld;
    
    temp = Yn + sigma*K*Uln_bar;
    Yn = sign(temp) .* min(abs(temp), 1);
    imshow(reshape(Un, [n,m])), title(['Iteration ', num2str(i)]), drawnow;
end

%% Algorithm End %%

% Output
figure;
subplot(1,3,1);
imshow(lena512);
title('Original image');

subplot(1,3,2);
imshow(reshape(F,[n,m]));
title('Noised image');

subplot(1,3,3);
imshow(reshape(Uln_bar,[n,m]));
title('Deblurred Image');








