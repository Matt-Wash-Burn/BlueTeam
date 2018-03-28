%% Feature Set Up
% This section will go throught the steps to extract some features that
% will be used to train our new NN. The one that dosen't "Blow Up" the cpu 


clc; clear all; close all; 

%% Load the data that was extracted form the csv file earlier. 

load TestingPixels.mat
load TrainingPixels.mat

%% Turn row data into a 48x48 img and resize

i = 3 ; % random image 
figure ; colormap gray;  
fim = reshape(trainingPixels(i, 2:end), [48,48])'; % row = 48 x 48  image
imagesc(fim)                                       % show the image
title(num2str(trainingPixels(i, 1)))               % show the label


sfim = imresize(fim, 0.5);                         % Resize to 24 x 24 img
imagesc(sfim); 

%% Frequency componenets from Nick submission 

%% Applying the filters on input images
im1_fft  = fft2(sfim);


gh = fftshift(im1_fft);

%% Nuetralizing the Phase to display Magnitude only
im1_M = abs(gh);


%% Inverse fft2
restoredP1 = log(abs(ifft2(im1_M*exp(1i*0)))+1);


re = fftshift(restoredP1);

%% Calculating plotting limits
I_Mag_min = min(min(abs(restoredP1)));
I_Mag_max = max(max(abs(restoredP1)));

figure; 
imshow(abs(re),[I_Mag_min I_Mag_max ]);


%% Extract lower frequencies by just cutting to 16 x 16 
newRe = re(5:20,5:20); 
% figure; imagesc(newRe); 

%% Reshape to return to NN 

stuff = reshape(newRe, [1,256]); 


%% Testing the function 

TheSolution = ExtractFeaturesMagic(trainingPixels(4,2:end)); 

figure; imagesc(reshape(newRe,[16,16])); 
