%% Gradient projection - Runnable file

%% Reading the image
% img = im2double(imread('lena.bmp'));
img = im2double(imread('lena512color.tiff'));
[m,n,c] = size(img);

%% Noisying the image
sigma = 0.01;
F = imnoise(img,'gaussian',0,sigma);


%% Parameters of the algorithm
alpha = 0.2;
tau = 0.25;
i = 200;
proj = @ProjectionL1Ball;

% Scalar for the l1 ball projection
z = 1;

%% For the Variatonal method
% sigma = 1/8 / tau;
% tau = 0.05;
% lambda = 8;

%% Function calling

u = GradientProjectionTV(alpha, tau, i, F, proj, z);
% u = VariationalMethodTest(tau, i, F, lambda, sigma);

%% Output
figure;
subplot(1,3,1);
imshow(img);
title('Original image');

subplot(1,3,2);
imshow(reshape(F,[m,n,c]));
title('Noised image');

subplot(1,3,3);
imshow(u);
title('Deblurred Image');
