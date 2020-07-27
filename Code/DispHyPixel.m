function [ ] = DispHyPixel( img, x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    figure;
    img = load(img,'photons');
    img = img.photons;
    plot(squeeze(img(x,y,:)));
end

