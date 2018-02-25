% Author: Nick DeMarco
% Hybrid Image

clc;
clear;
close all; % closes all figures

%% Setup
image1 = imread('fish.bmp');
image2 = imread('motorcycle.bmp');

image1 = imresize(image1,[307 453]);
image2 = imresize(image2,[307 453]);

figure('Name', 'Images','NumberTitle','off');imshowpair(image1, image2, 'montage');

image1double = double(image1)/255;
image2double = double(image2)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);

hs = 50; % filter half-size
fil = fspecial('gaussian', hs*2+1, 10); 
fil2 = fspecial('sobel'); 

%radius
r = 1000;

fftsize = 1024; % should be order of 2 (for speed) and include padding

%% Applying the filters on input image (1)
im1_fft  = fft2(im1,  fftsize, fftsize);                    % 1) fft im with padding
fil_fft = fft2(fil, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

sizeVar = size(im1_fft);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im1_fil_fft = im1_fft .* ~RGB_mask;

%% Repeat the implementation steps above on input image (2)

im2_fft  = fft2(im2,  fftsize, fftsize);                    % 1) fft im with padding
fil2_fft = fft2(fil2, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

sizeVar = size(im2_fft);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im2_fil_fft = im2_fft .* RGB_mask;

%% Ouput - Part 1
final_img = im1_fil_fft + im2_fil_fft;
final_image_fil = ifft2(final_img);
final_image_fil = final_image_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs);
figure('Name', 'Hybrid Image - Fish (Maginitude) & Motorcycle (Phase)','NumberTitle','off');imshow(final_image_fil);

%% Applying the filters on input image (1)
im2_fft_part2  = fft2(im2,  fftsize, fftsize);                    % 1) fft im with padding
fil_fft_part2 = fft2(fil, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

sizeVar = size(im2_fft_part2);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im2_fil_fft_part2 = im2_fft_part2 .* ~RGB_mask;

%% Repeat the implementation steps above on input image (2)

im1_fft_part2  = fft2(im1,  fftsize, fftsize);                    % 1) fft im with padding
fil2_fft_part2 = fft2(fil2, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

sizeVar = size(im1_fft_part2);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im1_fil_fft_part2 = im1_fft_part2 .* RGB_mask;

%% Ouput - Part 1
final_img_part2 = im2_fil_fft_part2 + im1_fil_fft_part2;
final_image_fil_part2 = ifft2(final_img_part2);
final_image_fil_part2 = final_image_fil_part2(1+hs:size(im2,1)+hs, 1+hs:size(im2, 2)+hs);
figure('Name', 'Hybrid Image - Motorcycle (Maginitude) & Fish (Phase)','NumberTitle','off');imshow(final_image_fil_part2);



