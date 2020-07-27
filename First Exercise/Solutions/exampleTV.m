cleanImg = im2double(imread('lena.bmp'));
noisyImg = imnoise(cleanImg,'gaussian',0,0.01);

% noisyImg = cleanImg + 0.1*randn(size(cleanImg));

uIso = gradientProjectionTv(noisyImg, 0.3, 200, 'iso');
uAniso = gradientProjectionTv(noisyImg, 0.3, 200, 'aniso');

figure, imshow(uIso)
figure, imshow(uAniso) 
%Anisotropic TV prefers horizontal and vertical edges and is "blockier" 
figure, imshow(noisyImg)

