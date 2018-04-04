function [outputArg1] = trainNetworks(newTrainingPix,emotion,indexn)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


%% Create a new data set with the magic function 
% tic %begin timeing for fun 
% newTrainingPix = double(trainingPixels(:,1:257)); 
% for q = 1: size(trainingPixels, 1)
%     newTrainingPix(q,2:end) = ExtractFeaturesMagic(trainingPixels(q,2:end)); 
% end 
% toc 
%% Reshape the data to Visualize example for the digits sample
figure    ;                                      % plot images
colormap(gray)                                  % set to grayscale
for i = 1:25                                    % preview first 25 samples
    subplot(5,5,i)                              % plot them in 6 x 6 grid
    digit = reshape(newTrainingPix(i, 1:end), [24,24])';    % row = 28 x 28 image
    imagesc(digit)                              % show the image
    title(num2str(emotion(i)))                    % show the label
end


%% The dataset stores samples in rows rather than in columns, so you need to
% transpose it. Then you will partition the data so that you hold out 1/3 of the data
% for model evaluation, and you will only use 2/3 for training our artificial neural network model.

n = size(newTrainingPix, 1);                    % number of samples in the dataset
targets  = emotion;                 % 1st column is |label|
targets(targets == 0) = 7;         % use '7' to present '0'
targetsd = dummyvar(targets);       % convert label into a dummy variable

% No need for the first column in the (trainingPixels) set any longer
inputs = newTrainingPix(:,2:end);               % the rest of columns are predictors

inputs = inputs';                   % trsanspose input
targets = targets';                 % trsanspose target
targetsd = targetsd';               % trsanspose dummy variable

%% partitioning the dataset based on random selection of indices
rng(1);                             % for reproducibility

%set n to 9000 to make sweep easier 
n = 28707; 
patitionObject = cvpartition(n,'Holdout',n/3);   % hold out 1/3 of the dataset

Xtrain = inputs(:, training(patitionObject));    % 2/3 of the input for training
Ytrain = targetsd(:, training(patitionObject));  % 2/3 of the target for training

Xtest = inputs(:, test(patitionObject));         % 1/3 of the input for testing
Ytest = targets(test(patitionObject));           % 1/3 of the target for testing
Ytestd = targetsd(:, test(patitionObject));      % 1/3 of the dummy variable for testing


%% Sweeo Code Block
%% Sweeping to choose different sizes for the hidden layer

sweep = [10,10:10:250];                 % parameter values to test
scores = zeros(length(sweep), 1);       % pre-allocation
% we will use models to save the several neural network result from this
% sweep and run loop
models = cell(length(sweep), 1);        % pre-allocation
x = double(Xtrain);                             % inputs
t = double(Ytrain);                             % targets
trainFcn = 'trainscg';                  % scaled conjugate gradient


for i = 1:length(sweep)
    tic
    hiddenLayerSize = sweep(i);         % number of hidden layer neurons
    net = patternnet(hiddenLayerSize);  % pattern recognition network
    net.divideParam.trainRatio = 70/100;% 70% of data for training
    net.divideParam.valRatio = 15/100;  % 15% of data for validation
    net.divideParam.testratio = 15/100; % 15% of data for testing
    net = train(net, x, t,'useParallel','yes');  % ,'useGPU','yes','showResources','yes'train the network
    simpleclusterOutputs = sim(net,x);
    
    % Ploting the ROC
    plotroc(t,simpleclusterOutputs,sprintf('%d Neurons' ,sweep(i)));
    
    formatSpec = "./figSaves/%dN%dRoc";
    savefigpath = sprintf(formatSpec,indexn,sweep(i));
    savefig(savefigpath);
    
    
    models{i} = net;                    % store the trained network
    p = net(double(Xtest));                     % predictions
    [~, p] = max(p);                    % predicted labels
    scores(i) = sum(Ytest == p) /length(Ytest);  % categorization accuracy
    
    

    toc
    
end
figure 
plot(sweep, scores, '.-')
xlabel('number of hidden neurons')
ylabel('categorization accuracy')
title('Number of hidden neurons vs. accuracy')

formatSpec = "./figSaves/%d_SweepResult";
savefigpath = sprintf(formatSpec,indexn);
savefig(savefigpath);
% Let's now plot how the categorization accuracy changes versus number of 
% neurons in the hidden layer.


end

