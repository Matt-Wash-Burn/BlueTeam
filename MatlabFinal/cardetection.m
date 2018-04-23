%% Author: Nick DeMarco & Brandon Bench
% Builds and trains neural network for use with classifying cars

%% Init
clear;
clc;
close all;

%% Load data set
data = load('fasterRCNNVehicleTrainingData.mat');
vehicleDataset = data.vehicleTrainingData;

%% Display first few rows of the data set.
vehicleDataset(1:4,:)

%% Test
% Add fullpath to the local vehicle data folder.
dataDir = fullfile(toolboxdir('vision'),'visiondata');
vehicleDataset.imageFilename = fullfile(dataDir, vehicleDataset.imageFilename);

% Read one of the images.
I = imread(vehicleDataset.imageFilename{10});

% Insert the ROI labels.
I = insertShape(I, 'Rectangle', vehicleDataset.vehicle{10});

% Resize and display image.
I = imresize(I,3);
figure
imshow(I)

%% Split data into a training and test set.
idx = floor(0.6 * height(vehicleDataset));
trainingData = vehicleDataset(1:idx,:);
testData = vehicleDataset(idx:end,:);

%% Create image input layer.
inputLayer = imageInputLayer([32 32 3]);