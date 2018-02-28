% Author: Nick DeMarco
% Hybrid Image

clc;
clear;
close all; % closes all figures

%% Setup
image1 = imread('./data/dog.bmp');
image2 = imread('.data/einstein.bmp');
image3 = imread('.data/fish.bmp');

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

%% Nuetralizing the Phase to display Magnitude only
im1_M = abs(im1_fft);
im2_M = abs(im2_fft);
im3_M = abs(im3_fft);

%% Inverse fft2
restoredP1 = log(abs(ifft2(im1_M*exp(1i*0)))+1);
restoredP2 = log(abs(ifft2(im2_M*exp(1i*0)))+1);
restoredP3 = log(abs(ifft2(im3_M*exp(1i*0)))+1);

%% Calculating plotting limits
I_Mag_min = min(min(abs(restoredP1)));
I_Mag_max = max(max(abs(restoredP1)));


figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image1), title("Fluffy")
subplot(1,2,2), 
imshow(abs(restoredP1),[I_Mag_min I_Mag_max ]);
title("Dog Phase Nuetralized")

figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image2), title("Mr. Einstein")
subplot(1,2,2), 
imshow(abs(restoredP2),[I_Mag_min I_Mag_max ]);
title("Albert Phase Nuetralized")

figure('position', [200, 200, 1000, 400]); subplot(1,2,1), imshow(image3), title("Pescado")
subplot(1,2,2), 
imshow(abs(restoredP3),[I_Mag_min I_Mag_max ]);
title("Fish Phase Nuetralized")
