% Author: Brandon Bench
% Hybrid Image

clc;
clear;
close all; % closes all figures

%% Setup
image1 = imread('./data/dog.bmp');
image2 = imread('./data/einstein.bmp');
image3 = imread('./data/fish.bmp');

% figure('Name', 'Image1: Dog','NumberTitle','off');imshow(image1);
% figure('Name', 'Image2: Einstein','NumberTitle','off');imshow(image2);
% figure('Name', 'Image3: Fish','NumberTitle','off');imshow(image3);

image1double = double(image1)/255;
image2double = double(image2)/255;
image3double = double(image2)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);
im3 = rgb2gray(image3double);

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);
[im3h, im3w] = size(im3);

hs = 50; % filter half-size
fil = fspecial('gaussian', hs*2+1, 10); 
fil2 = fspecial('sobel'); 

%radius
r = 1000;

fftsize = 1024; % should be order of 2 (for speed) and include padding

%% Applying the filters on input images
% im1_fft  = fft2(im1,  fftsize, fftsize);
% im2_fft  = fft2(im2,  fftsize, fftsize);
% im3_fft  = fft2(im3,  fftsize, fftsize);
figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image1)
subplot(1,2,2), imagesc(log(abs(fftshift(fft2(im1)))));
figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image2)
subplot(1,2,2), imagesc(log(abs(fftshift(fft2(im2)))));
figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image3)
subplot(1,2,2), imagesc(log(abs(fftshift(fft2(im3)))));
