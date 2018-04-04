clc; close all; clear all; 
load AllPix.mat


frameSize = [24 24];

newTrainingPixCoif = double(pix(:,1:(frameSize(1)*frameSize(1))));
newTrainingPixHaar = double(pix(:,1:(frameSize(2)*frameSize(2))));
q=1; 
newTrainingPixCoif(q,1:end) = ExtractFeaturesMagic(pix(q,1:end), 'coif4', frameSize(1));
newTrainingPixHaar(q,1:end) = ExtractFeaturesMagic(pix(q,1:end), 'haar', frameSize(2));

i = 1; 
subplot(2,1,1)                              % plot them in 6 x 6 grid
digit = reshape(newTrainingPixCoif(i, 1:end), [24,24])';    % row = 28 x 28 image
imagesc(digit)                              % show the image

subplot(2,1,2)
digit = reshape(newTrainingPixHaar(i, 1:end), [24,24])';    % row = 28 x 28 image
imagesc(digit)                              % show the image
