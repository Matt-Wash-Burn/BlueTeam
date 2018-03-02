% Author: Abdallah S. Abdallah aua639@psu.edu


clear;
clc;

close all; % closes all figures

%% Setup
originalBW1 = imread('C:\Users\njd5223\Downloads\data\data\bird.bmp');
originalBW2 = imread('C:\Users\njd5223\Downloads\data\data\marilyn.bmp');
originalBW3 = imread('C:\Users\njd5223\Downloads\data\data\dog.bmp');
originalBW4 = imread('C:\Users\njd5223\Downloads\data\data\plane.bmp');

image1_gray = rgb2gray(originalBW1);
image2_gray = rgb2gray(originalBW2);
image3_gray = rgb2gray(originalBW3);
image4_gray = rgb2gray(originalBW4);

%imshow(image1_gray);

cols = 410;
rows = 360;

outBirdN = imresize(image1_gray,[rows, cols]*2, 'nearest');
outMarN = imresize(image2_gray,[rows, cols]*2,'nearest');
outDogN = imresize(image3_gray,[rows, cols]*2,'nearest');
outJetN = imresize(image4_gray,[rows, cols]*2,'nearest');

imgFinal = [outBirdN outMarN ;outDogN outJetN];

e1 = edge(outBirdN,'canny');
e2 = edge(outMarN,'canny');
e3 = edge(outDogN,'canny');
e4 = edge(outJetN,'canny');
%e2 = edge(outDogB,'canny');
%e3 = edge(outDogC,'canny');
imgFinalN = [e1 e2 ;e3 e4];
se = strel('disk',18);
% dilateBW = imdilate(originalBW,se);
% figure, imshow(dilateBW);title('dilateBW');
% 
% 
% erodeBW = imerode(originalBW,se);
% figure, imshow(erodeBW); title('erodeBW');

imshow(imgFinal);

%openBW = imopen(e1,se);
%figure, imshow(openBW); title('openBW');


closeBW = imclose(imgFinalN,se);
figure, imshow(closeBW); title('closeBW');

new = imfill(closeBW, 'holes');
%new = imdilate(new,se);
new = immultiply(imgFinal, new);

figure, imshow(new); title('new');

%% Using SE = strel('square',W)
% disp('hit any key to continue');
% pause;
% 
% se = strel('diamond',5);
% dilateBW = imdilate(originalBW,se);
% figure, imshow(dilateBW);title('dilateBW');
% 
% 
% erodeBW = imerode(originalBW,se);
% figure, imshow(erodeBW); title('erodeBW');
% 
% 
% openBW = imopen(originalBW,se);
% figure, imshow(openBW); title('openBW');
% 
% 
% closeBW = imclose(originalBW,se);
% figure, imshow(closeBW); title('closeBW');
