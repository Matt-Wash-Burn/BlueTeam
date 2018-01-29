
% Author: Abdallah S. Abdallah aua639@psu.edu
% MakeHybrid - Version: 0.1


%Usefull link https://stackoverflow.com/questions/25474326/abs-function-for-fft2-is-not-working-in-matlab

clear;clc;

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = imread('./data/dog.bmp');
image2 = imread('./data/cat.bmp');

figure;imshowpair(image1, image2, 'montage');


image1double = double (image1)/255;
image2double = double (image2)/255;

im2 = rgb2gray(image1double);
im1 = rgb2gray(image2double);

[im1h, im1w] = size(im1);
[im2h, im2w] = size(im2);
 
hs = 50; % filter half-size
%fil = fspecial('gaussian', hs*2+1, 10); 
% fil = fspecial('sobel'); %, hs*2+1, 10); 
fil = fspecial('disk',10); %, hs*2+1, 10); 

 
fftsize = 1024; % should be order of 2 (for speed) and include padding


%% Applying the filters on input image (1)
im1_fft  = fft2(im1,  fftsize, fftsize);                  
im2_fft = fft2(im2, fftsize, fftsize);                   
fil_fft = fft2(fil,fftsize,fftsize); 

figure ; 
fontSize = 11;
n = 4; r = 2;  

%% Show first image
subplot(r,n,1); 
imshow(im1, []);
title('Gray Image', 'FontSize', fontSize, 'Interpreter', 'None');

subplot(r,n,5); 
imshow(im2,[]); 

%% Fourier Transforms

subplot(r,n,2);
displayFFT(im1_fft); 
% imshow(S1,[]);
% O = ifft2(S); 
title('FFT', 'FontSize', fontSize, 'Interpreter', 'None');
subplot(r,n,6);
displayFFT(im2_fft); 
% imshow(S2,[]); 

%% Croping The F Domain 


mask = zeros(size(im1_fft));   %Same size as FFT1


radius = 50; %radius of the circle 
maskSize = size(mask); 
x = maskSize(2)/2; 
y = maskSize(1)/2;


RGBmask1 = insertShape(mask,'filledcircle',[x y radius*2]);
RGBmask2 = insertShape(mask,'filledcircle',[x y radius]);

graymask1 = rgb2gray(RGBmask1); 
graymask2 = rgb2gray(RGBmask2); 

o1 = graymask1 .*fftshift(im1_fft) ; 
o2 = ~graymask2 .* fftshift(im2_fft); 

T = o1+o2 ; 
T=ifftshift(T); 
subplot(r,n,3);
% imshow(o1,[]);
displayFFT(o1);
% displayFFT(T); 
title('Masked Image', 'FontSize', fontSize, 'Interpreter', 'None');

subplot(r,n,7); 
displayFFT(o2); 

subplot(r,n,4); 
displayFFT(T); 
%% Multiplying in Frequency domain instead of concolution in spatial domain
im1_fil = ifft2(T);                               % 4) inverse fft2
im1_fil = im1_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding

subplot(r,n,8); 
imshow(im1_fil);

figure; imshow(im1_fil);



