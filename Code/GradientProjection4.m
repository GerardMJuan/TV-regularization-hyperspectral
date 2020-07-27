%% Gradient projection - Runnable file for Hyperspectral images
nImages = 3;
nProj = 2;
images = {'SanFrancisco.mat', 'LoResFemale2.mat', 'StanfordMemorial.mat'};
projections = {@ProjectionL1Ball, @ProjL1Both};

%% Parameters of the algorithm
tau = 0.25;         % Time unit
it = 200;            % Number of iterations
z = 1;              % Used for L1 projection, won't change

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
    % figure;
    % imshow(photons(:,:,1),[]);
    
    % Noise the image
    noised = image + 0.05*randn(size(image));
    filename = ['noised' imgPath(1:size(imgPath,2)-4) '.mat'];
    save(filename,'noised');

    % figure;
    % imshow(photons(:,:,1),[]);

    % Do each type of projection and save it into a file
     for j = 1:nProj
        filename = ['ResultsMoreNoise5/result' imgPath(1:size(imgPath,2)-4) 'Projection' int2str(j) '.txt'];
        % Change alpha parameter
        a = 1;
        peaksnr = zeros(1,10);
        ssimval = zeros(1,10);
        samave = zeros(1,10);
        samvar = zeros(1,10);
        for alpha = 2:0.2:4
            denoised = GradientProjectionTV(alpha, tau, it, noised, projections{j}, z);
            peaksnr(a) = psnr(image, denoised);
            ssimval(a) = ssim(denoised, image);
            sam = zeros(m, n);
            for k=1:m
                for l=1:n
                    sam(k, l) = abs(hyperSam(squeeze(denoised(k,l,:)), squeeze(image(k,l,:))));
                end
            end
            samvar(a) = var(sam(:));
            samave(a) = mean(sam(:));
            a = a + 1;
        end
        save(filename, 'peaksnr', 'ssimval','samave','samvar', '-ascii');
    end
    % figure;
    % imshow(photons(:,:,1),[]);
    
end