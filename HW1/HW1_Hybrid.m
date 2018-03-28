% Author: Nick DeMarco
% Hybrid Image

clc;
clear;
close all; % closes all figures

%% Setup
image1 = imread('.data/fish.bmp');
image2 = imread('.data/motorcycle.bmp');

image1 = imresize(image1,[307 453]);
image2 = imresize(image2,[307 453]);

figure('Name', 'Original Images','NumberTitle','off');imshowpair(image1, image2, 'montage');
title("Original Images");

image1double = double(image1)/255;
image2double = double(image2)/255;

im1 = rgb2gray(image1double);
im2 = rgb2gray(image2double);

figure('Name', 'Grayscale Images','NumberTitle','off');imshowpair(im1, im2, 'montage');
title("Grayscale Images");

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);

rows = max(im1h, im2h);
cols = max(im1w, im2w);

%% Take the FFT of the two images
im1_FFT = fft2(im1, rows, cols);
im2_FFT = fft2(im2, rows, cols);

%% Find magnitude and phase of the two images
mag1 = abs(im1_FFT);
mag2 = abs(im2_FFT);

phase1 = angle(im1_FFT);
phase2 = angle(im2_FFT);

%% Recompute the frequency
output1 = mag1 .* exp(1i*phase2);
output2 = mag2 .* exp(1i*phase1);

%% Find inverse images
inv1 = real(ifft2(output1));
inv2 = real(ifft2(output2));

%% Diplay New Hybrid Images
figure('Name', 'Hybrid Images','NumberTitle','off');imshowpair(inv1, inv2, 'montage');
title("Hybrid Images");

