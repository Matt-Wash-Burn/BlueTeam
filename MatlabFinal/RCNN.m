clear;
close all;
clc;

projectdir = 'E:\IoT\Final';
cifar10Data = projectdir;

url = 'https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz';

helperCIFAR10Data.download(url,cifar10Data);

[trainingImages,trainingLabels,testImages,testLabels] = helperCIFAR10Data.load(cifar10Data);


% figure;
% thumbnails = trainingImages(:,:,:,1:100);
% montage(thumbnails);

%%
% Create the image input layer for 32x32x3 CIFAR-10 images
[height, width, numChannels, ~] = size(trainingImages);

imageSize = [height width numChannels];
inputLayer = imageInputLayer(imageSize)

numImageCategories = 10;
categories(trainingLabels)

%%
% Convolutional layer parameters
filterSize = [5 5];
numFilters = 32;

middleLayers = [
    
% The first convolutional layer has a bank of 32 5x5x3 filters. A
% symmetric padding of 2 pixels is added to ensure that image borders
% are included in the processing. This is important to avoid
% information at the borders being washed away too early in the
% network.
convolution2dLayer(filterSize, numFilters, 'Padding', 2)

% Note that the third dimension of the filter can be omitted because it
% is automatically deduced based on the connectivity of the network. In
% this case because this layer follows the image layer, the third
% dimension must be 3 to match the number of channels in the input
% image.

% Next add the ReLU layer:
reluLayer()

% Follow it with a max pooling layer that has a 3x3 spatial pooling area
% and a stride of 2 pixels. This down-samples the data dimensions from
% 32x32 to 15x15.
maxPooling2dLayer(3, 'Stride', 2)

% Repeat the 3 core layers to complete the middle of the network.
convolution2dLayer(filterSize, numFilters, 'Padding', 2)
reluLayer()
maxPooling2dLayer(3, 'Stride',2)

convolution2dLayer(filterSize, 2 * numFilters, 'Padding', 2)
reluLayer()
maxPooling2dLayer(3, 'Stride',2)

]

%%
finalLayers = [
    
% Add a fully connected layer with 64 output neurons. The output size of
% this layer will be an array with a length of 64.
fullyConnectedLayer(64)

% Add an ReLU non-linearity.
reluLayer

% Add the last fully connected layer. At this point, the network must
% produce 10 signals that can be used to measure whether the input image
% belongs to one category or another. This measurement is made using the
% subsequent loss layers.
fullyConnectedLayer(numImageCategories)

% Add the softmax loss layer and classification layer. The final layers use
% the output of the fully connected layer to compute the categorical
% probability distribution over the image classes. During the training
% process, all the network weights are tuned to minimize the loss over this
% categorical distribution.
softmaxLayer
classificationLayer
]

%%
%Combine the input, middle, and final layers.
layers = [
    inputLayer
    middleLayers
    finalLayers
    ]

%%
%Initialize the first convolutional layer weights using normally distributed random numbers with 
% standard deviation of 0.0001. This helps improve the convergence of training.
layers(2).Weights = 0.0001 * randn([filterSize numChannels numFilters]);

% Set the network training options
opts = trainingOptions('sgdm', ...
    'Momentum', 0.9, ...
    'InitialLearnRate', 0.001, ...
    'LearnRateSchedule', 'piecewise', ...
    'LearnRateDropFactor', 0.1, ...
    'LearnRateDropPeriod', 8, ...
    'L2Regularization', 0.004, ...
    'MaxEpochs',10 , ...
    'MiniBatchSize', 64, ...
    'Verbose', true);

% A trained network is loaded from disk to save time when running the
% example. Set this flag to true to train the network.
doTraining = false;

if doTraining    
    % Train a network.
    cifar10Net = trainNetwork(trainingImages, trainingLabels, layers, opts);
else
    % Load pre-trained detector for the example.
    load('rcnnStopSigns.mat','cifar10Net')       
end

%%
% % Extract the first convolutional layer weights
% w = cifar10Net.Layers(2).Weights;
% 
% w1 = uint8(w);
% % rescale the weights to the range [0, 1] for better visualization
% w = rescale(w1);
% 
% figure
% montage(w)

%%
% Run the network on the test set.
YTest = classify(cifar10Net, testImages);
%testt = imread('stopSign.jpg');
%testt = imresize(testt, [32 32]);
%YTest = classify(cifar10Net, testt);
% Calculate the accuracy.
accuracy = sum(YTest == testLabels)/numel(testLabels)

%%
% Load the ground truth data
data = load('stopSignsAndCars.mat', 'stopSignsAndCars');
stopSignsAndCars = data.stopSignsAndCars;

% Update the path to the image files to match the local file system
visiondata = fullfile(toolboxdir('vision'),'visiondata');
stopSignsAndCars.imageFilename = fullfile(visiondata, stopSignsAndCars.imageFilename);

% Display a summary of the ground truth data
summary(stopSignsAndCars)

%%
% % Only keep the image file names and the stop sign ROI labels
% stopSigns = stopSignsAndCars(:, {'imageFilename','stopSign'});
% 
% % Display one training image and the ground truth bounding boxes
% I = imread(stopSigns.imageFilename{7});
% 
% I = insertObjectAnnotation(I,'Rectangle',stopSigns.stopSign{7},'stop sign','LineWidth',8);
% 
% figure
% imshow(I)

%%
% Read test image
load('rcnnStopSigns.mat','rcnn')   
testImage = carex;

% Detect stop signs
[bboxes,score,label] = detect(rcnn,testImage,'MiniBatchSize',128)

% Display the detection results
[score, idx] = max(score);

bbox = bboxes(idx, :);
annotation = sprintf('%s: (Confidence = %f)', label(idx), score);

outputImage = insertObjectAnnotation(testImage, 'rectangle', bbox, annotation);

figure
imshow(outputImage)

%[score, idx] = max(score);

% bbox = bboxes(idx, :);

% thatthing = zeros(4,4);
% thing = zeros(4,1);
% counter = 1;
% for q = 1:size(score)
%    if score(q) >= .90 
%         thing(counter,1) = sprintf('%s: (Confidence = %f)', label(q,1), score(q,1));         
%         thatthing(counter,:) = bboxes(q,:);
%         counter = counter + 1;
%    end
% end

% outputImage = insertObjectAnnotation(testImage, 'rectangle', thatthing, thing);
% 
% figure
% imshow(outputImage)
        
% annotation = sprintf('%s: (Confidence = %f)', label(2), score(2));
% 
% outputImage = insertObjectAnnotation(testImage, 'rectangle', bboxes(2,:), annotation);
% 
% figure
% imshow(outputImage)