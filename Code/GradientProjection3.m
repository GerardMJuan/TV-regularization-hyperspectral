%% Gradient projection - Runnable file for Hyperspectral images
nImages = 3;
nProj = 2;
images = {'SanFrancisco.mat', 'LoResFemale2.mat', 'StanfordMemorial.mat'};
projections = {@ProjectionL1Ball, @ProjL1Both};

noise = [0.025 0.05];
noiseName = {'ResultsHighFinal/', 'ResultsLowFinal/'};
noiseAlpha = {(0.8:0.1:5), (2:0.25:10)};
%% Parameters of the algorithm
tau = 0.25;         % Time unit 
it = 200;            % Number of iterations
z = 1;              % Used for L1 projection, won't change

for b = 1:2 

peaksnr = zeros(10,nProj+2,3);
ssimval = zeros(10,nProj+2,3);
samave = zeros(10,nProj+2,3);
samvar = zeros(10,nProj+2,3);

for i = 1:nImages
    imgPath = images{i};
    % Load the image and adapt it to have less computation time
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
    % Noise the image
    noised = image + noise(b)*randn(size(image));
    
    for j = 1:nProj
        a = 1;
        %% LowNoise
        for alpha = noiseAlpha{b}
            denoised = GradientProjectionTV(alpha, tau, it, noised, projections{j}, z);
            peaksnr(a,1,i) = alpha;
            peaksnr(a,2,i) = a;
            peaksnr(a,j+2,i) = psnr(image, denoised);
            ssimval(a,1,i) = alpha;
            ssimval(a,2,i) = a;
            ssimval(a,j+2,i) = ssim(denoised, image);
            sam = zeros(m, n);
            for k=1:m
               for l=1:n
                   sam(k, l) = abs(hyperSam(squeeze(denoised(k,l,:)), squeeze(image(k,l,:))));
               end
            end
            samvar(a,1,i) = alpha;
            samvar(a,2,i) = a;
            samvar(a,j+2,i) = var(sam(:));
            samave(a,1,i) = alpha;
            samave(a,2,i) = a;
            samave(a,j+2,i) = mean(sam(:));
            a = a + 1;
        end

    end

end

peaksnr = mean(peaksnr,3);
ssimval = mean(ssimval,3);
samave = mean(samave,3);
samvar = mean(samvar,3);

filename1 = [noiseName{b} 'dataPSNR3.dat'];
filename2 = [noiseName{b} 'dataSSIMVAL3.dat'];
filename3 = [noiseName{b} 'dataSAMAVE3.dat'];
filename4 = [noiseName{b} 'dataSAMVAR3.dat'];

csvwrite(filename1,peaksnr);
csvwrite(filename2,ssimval);
csvwrite(filename3,samave);
csvwrite(filename4,samvar);
end