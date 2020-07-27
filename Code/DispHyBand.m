function [  ] = DispHyBand( img, band )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    figure;
    img = load(img,'photons');
    img = img.photons;
    imshow(img(:,:,band),[]);

end

