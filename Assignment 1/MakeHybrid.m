
% Author: Abdallah S. Abdallah aua639@psu.edu
% MakeHybrid - Version: 0.1



clc;

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = cat;
image2 = dog;

figure;imshowpair(image1, image2, 'montage');


image1double = double (image1)/255;

image2double = double (image2)/255;

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

%% Multiplying in Frequency domain instead of concolution in spatial domain
%im1_fil_fft = im1_fft .* fil_fft;                           % 3) multiply fft images
%im1_fil = ifft2(im1_fil_fft);                               % 4) inverse fft2
%im1_fil = im1_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding

sizeVar = size(im1_fft);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im1_fil_fft = im1_fft .* ~RGB_mask;

%figure;imshow(im1_fil);



%% Repeat the previous work using different filter (sobel)

%% Repeat the implementation steps above on input image (2)

im2_fft  = fft2(im2,  fftsize, fftsize);                    % 1) fft im with padding
fil2_fft = fft2(fil2, fftsize, fftsize);                    % 2) fft fil, pad to same size as image

%% Multiplying in Frequency domain instead of concolution in spatial domain
%im1_fil_fft = im1_fft .* fil_fft;                           % 3) multiply fft images
%im1_fil = ifft2(im1_fil_fft);                               % 4) inverse fft2
%im1_fil = im1_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs); % 5) remove padding

sizeVar = size(im2_fft);
mask = zeros(sizeVar);
RGB = insertShape(mask, 'FilledCircle', [0, 0, r]);
RGB_mask = RGB(:, :, 1) > 0;
im2_fil_fft = im2_fft .* RGB_mask;

%figure;imshow(im2_fil);

final_img = im1_fil_fft + im2_fil_fft;
final_image_fil = ifft2(final_img);
final_image_fil = final_image_fil(1+hs:size(im1,1)+hs, 1+hs:size(im1, 2)+hs);
figure;imshow(final_image_fil);













%% your Algorithm below should implement the following steps
% 1) Apply FFT on image 1 , then extract the output of low pass filter and name it as out1
% 2) Apply FFT on image 2, then extract the ooutput of high pass filter and name it out2
% 3) mix  out1 and out2
% 4) Transform back to spatial intensity domain and display the final outcome


% low pass filter

kernel_low = [1/16 1/8 1/16;
            1/8 1/4 1/8; 
            1/16 1/8 1/16];

% high pass filter (sharpenning)
kernel_high = [0 -1 0; 
           -1 5 -1;
           0 -1 0];
        

        
        
