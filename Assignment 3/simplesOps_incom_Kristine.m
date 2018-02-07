% Author: Abdallah S. Abdallah aua639@psu.edu


clear;
clc;

close all; % closes all figures

%% Setup
%part of lab 2 below

% originalBW = imread('./data/dog.bmp');
% image1_gray = rgb2gray(originalBW);
% imshow(image1_gray);

% %upsampling technique 1
% smp1 = imresize(image1_gray, 2, 'nearest');
% edge1 = edge(smp1, 'canny');
% 
% %upsampling technique2
% smp2 =imresize(image1_gray, 2, 'bilinear');
% edge2 = edge(smp2, 'canny');
% 
% %upsampling technique 3
% smp3 = imresize(image1_gray, 2, 'bicubic');
% edge3 = edge(smp3, 'canny');


%used for lab 2 and 3
se = strel('disk',5);


% dilateBW = imdilate(image1_gray,se);
% figure, imshow(dilateBW);title('dilateBW');
% 
% 
% erodeBW = imerode(image1_gray,se);
% figure, imshow(erodeBW); title('erodeBW');


% openBW = imopen(edge1,se);
% figure, imshow(openBW); title('openBW');


%% Lab 2
% closeBW1 = imclose(edge1,se);
% figure, imshow(closeBW1); title('closeBW1');
% 
% closeBW2 = imclose(edge2,se);
% figure, imshow(closeBW2); title('closeBW2');
% 
% closeBW3 = imclose(edge3,se);
% figure, imshow(closeBW3); title('closeBW3');
% 
% 
% 
% BW1 = imfill(closeBW1, 'holes');
% BW2 = imfill(closeBW2, 'holes');
% BW3 = imfill(closeBW3, 'holes');
% 
% 
% 
% mult1 = immultiply(smp1, BW1);
% figure, imshow(mult1); title('mult1');
% 
% mult2 = immultiply(smp2, BW2);
% figure, imshow(mult2); title('mult2');
% 
% mult3 = immultiply(smp3, BW3);
% figure, imshow(mult3); title('mult3');

%% Lab 3


originalBW1 = imread('./data/dog.bmp');
originalBW2 = imread('./data/cat.bmp');
originalBW3 = imread('./data/bird.bmp');
originalBW4 = imread('./data/fish.bmp');


image1_gray = rgb2gray(originalBW1);
image2_gray = rgb2gray(originalBW2);
image3_gray = rgb2gray(originalBW3);
image4_gray = rgb2gray(originalBW4);


out1 = imresize(image1_gray, [180, 205]);
out2 = imresize(image2_gray, [180, 205]);
out3 = imresize(image3_gray, [180, 205]);
out4 = imresize(image4_gray, [180, 205]);


out = [out2 out3; out4 out1];

figure;imshow(out);

%upsampling technique 1
smp1 = imresize(out, 2, 'nearest');
edge1 = edge(smp1, 'canny');

%upsampling technique2
smp2 =imresize(out, 2, 'bilinear');
edge2 = edge(smp2, 'canny');

%upsampling technique 3
smp3 = imresize(out, 2, 'bicubic');
edge3 = edge(smp3, 'canny');

closeBW1 = imclose(edge1,se);
figure, imshow(closeBW1); title('closeBW1');

closeBW2 = imclose(edge2,se);
figure, imshow(closeBW2); title('closeBW2');

closeBW3 = imclose(edge3,se);
figure, imshow(closeBW3); title('closeBW3');



BW1 = imfill(closeBW1, 'holes');
BW2 = imfill(closeBW2, 'holes');
BW3 = imfill(closeBW3, 'holes');



mult1 = immultiply(smp1, BW1);
figure, imshow(mult1); title('mult1');

mult2 = immultiply(smp2, BW2);
figure, imshow(mult2); title('mult2');

mult3 = immultiply(smp3, BW3);
figure, imshow(mult3); title('mult3');

%% Using SE = strel('square',W)
% disp('hit any key to continue');
% pause;
% 
% se = strel('diamond',5);
% dilateBW = imdilate(image1_gray,se);
% figure, imshow(dilateBW);title('dilateBW');
% 
% 
% erodeBW = imerode(image1_gray,se);
% figure, imshow(erodeBW); title('erodeBW');
% 
% 
% openBW = imopen(image1_gray,se);
% figure, imshow(openBW); title('openBW');
% 
% 
% closeBW = imclose(image1_gray,se);
% figure, imshow(closeBW); title('closeBW');
