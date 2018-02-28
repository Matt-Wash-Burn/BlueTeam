% Author: Brandon Bench
% Hybrid Image

clc;
clear;
close all; % closes all figures

%% Setup
image1 = imread('./data/dog.bmp');
image2 = imread('./data/einstein.bmp');
image3 = imread('./data/fish.bmp');

figure; imshow(image1);
title("Dog - Original Image");
figure; imshow(image2);
title("Einstein - Original Image");
figure; imshow(image3);
title("Fish - Original Image");

image1double = double(image1)/255;
image2double = double(image2)/255;
image3double = double(image3)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);
im3 = rgb2gray(image3double);

figure; imshow(im1);
title("Dog - Grayscale Image");
figure; imshow(im2);
title("Einstein - Grayscale Image");
figure; imshow(im3);
title("Fish - Grayscale Image");


%% Applying the filters on input images
im1_fft  = fft2(im1);
im2_fft  = fft2(im2);
im3_fft  = fft2(im3);

%% Nuetralizing the Magnitude to display Phase only
im1_P = exp(1i*angle(im1_fft));
im2_P = exp(1i*angle(im2_fft));
im3_P = exp(1i*angle(im3_fft));

%% Inverse fft2
restoredP1 = ifft2(im1_P);
restoredP2 = ifft2(im2_P);
restoredP3 = ifft2(im3_P);

%% Calculating plotting limits
I_Phase_min = min(min(abs(restoredP1)));
I_Phase_max = max(max(abs(restoredP1)));


figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image1), title("Fluffy")
subplot(1,2,2), 
imshow(abs(restoredP1),[I_Phase_min I_Phase_max ]);
title("Dog Magnitude Nuetralized")

figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image2), title("Mr. Einstein")
subplot(1,2,2), 
imshow(abs(restoredP2),[I_Phase_min I_Phase_max ]);
title("Albert Magnitude Nuetralized")

figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image3), title("Pescado")
subplot(1,2,2), 
imshow(abs(restoredP3),[I_Phase_min I_Phase_max ]);
title("Fish Magnitude Nuetralized")