%% Gradient projection - Runnable file for Hyperspectral images
nImages = 3;
nProj = 7;  
images = {'SanFrancisco.mat', 'LoResFemale2.mat', 'StanfordMemorial.mat'};
projections = {@Anisotropic211, @Isotropic221, @Anisotropicl111, @Isotropicl2, @ProjL1Derivative, @ProjectionL1Ball, @ProjL1Both};
% initialval = [0.3 0.4 0.4 0.045 0.055 2.5 4.75];
initialval = [0.15 0.2 0.025 0.02 0.025 1.1 2.1];

%% Parameters of the algorithm
tau = 0.25;         % Time unit 
it = 200;            % Number of iterations
z = 1;              % Used for L1 projection, won't change

psnrFile = zeros(nImages,nProj);
ssimvalFile = zeros(nImages,nProj);
samvarFile = zeros(nImages,nProj);
samaveFile = zeros(nImages,nProj);
alphaEnd = zeros(1,nProj);

for i = 1:nImages
    imgPath = images{i};
 %   Load the image and adapt it to have less computation time
    image = load(imgPath,'photons');
    image = imresize(image.photons,0.5);
    minImg = min(image(:));
    maxImg = max(image(:));
    image = (image-minImg) ./ (maxImg-minImg);
    crop = 150;
    if i == 3
        image = image(crop:crop+150,crop:crop+150,:);
    else
        image = image(1:crop,1:crop,:);
    end
    [m,n,c] = size(image);
%     figure;
%     imshow(photons(:,:,1),[]);
%     
  %  Noise the image
    noised = image + 0.05*randn(size(image));
    filename1 = ['NoisedLowNoise/noised' imgPath(1:size(imgPath,2)-4) '.mat'];
    filename2a = ['NoisedLowNoise/noised' imgPath(1:size(imgPath,2)-4) '1.png'];
    filename2b = ['NoisedLowNoise/noised' imgPath(1:size(imgPath,2)-4) '50.png'];
    filename2c = ['NoisedLowNoise/noised' imgPath(1:size(imgPath,2)-4) '100.png'];
    img = noised;
    %img = load(filename1,'noised');
    %img = img.noised;
    img(:,:,1) = imadjust(img(:,:,1)); 
    img(:,:,50) = imadjust(img(:,:,50)); 
    img(:,:,100) = imadjust(img(:,:,100)); 
    imwrite(img(:,:,1), filename2a);
    imwrite(img(:,:,50), filename2b);
    imwrite(img(:,:,100), filename2c);
     for j = 1:nProj
%         if i == 1
%         % Change alpha parameter
%             a = 1;
%             alpha = initialval(j);
%             denoised = GradientProjectionTV(alpha, tau, it, noised, projections{j}, z);
%             psnr1 = psnr(image, denoised);
%             alpha = alpha + 0.001;
%             while a < 10
%                 denoised = GradientProjectionTV(alpha, tau, it, noised, projections{j}, z);
%                 psnr2 = psnr(image, denoised);
%                 if (psnr1 - psnr2) > 0
%                     alpha = alpha - 0.001;
%                 else
%                     alpha = alpha + 0.001;
%                 end
%                 psnr1 = psnr2;                
%                 a = a + 1;
%             end
%             alphaEnd(j) = alpha;
%         end
        
%         denoised = GradientProjectionTV(alphaEnd(j), tau, it, noised, projections{j}, z);
%         filename = ['ResultsLowFinal/Images/denoised' imgPath(1:size(imgPath,2)-4) 'Projection' int2str(j) '.mat'];
%         save(filename,'denoised');
%         imwrite(A,filename)
       
        filename3 = ['ResultsLowFinal/Images/denoised' imgPath(1:size(imgPath,2)-4) 'Projection' int2str(j) '.mat'];
        filename4 = ['ResultsLowFinal/Images/denoised' imgPath(1:size(imgPath,2)-4) 'Projection' int2str(j) '.png'];
        img2 = load(filename3,'denoised');
        denoised = img2.denoised;
        %img2(:,:,50) = imadjust(img2(:,:,50)); 
        %imwrite(img2(:,:,50), filename4);
        psnrFile(i,j) = psnr(image, noised)
        ssimvalFile(i,j) = ssim(denoised, image);
%         sam = zeros(m, n);
%         for k=1:m
%             for l=1:n
%                 sam(k, l) = abs(hyperSam(squeeze(denoised(k,l,:)), squeeze(image(k,l,:))));
%             end
%         end
%         samvarFile(i,j) = var(sam(:));
%         samaveFile(i,j) = mean(sam(:));
     end
%     filename = 'ResultsLowFinal/psnrResults.txt';
%     save(filename, 'psnrFile', '-ascii');
%     filename = 'ResultsLowFinal/ssimvalResults.txt';
%     save(filename, 'ssimvalFile', '-ascii');
%     filename = 'ResultsLowFinal/samvarResults.txt';
%     save(filename, 'samvarFile', '-ascii');
%     filename = 'ResultsLowFinal/samaveResults.txt';
%     save(filename, 'samaveFile', '-ascii');
end