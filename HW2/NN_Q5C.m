% % Gathered and edited by  Abdallah S. Abdallah aua639@psu.edu
% % based on the tutorial at https://blogs.mathworks.com/loren/2015/08/04/artificial-neural-networks-for-beginners/#1168dbb4-1365-4b63-8326-140263e2072f
%
% %
clear;
clc;
close all; % closes all figures


% trainingPixels = fer2013;
tic
load Part1.mat
% load TrainingPixels.mat
toc
disp("loaded")
time1 =tic;
trainNetworks(newTrainingPixCoif,emotion,1)
trainNetworks(newTrainingPixHaar,emotion,2)
toc(time1)

