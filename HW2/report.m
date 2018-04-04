clc; clear all; close all; 

% This report contains the awnsers to questions posed in the Deliverable 

%Each of the ROC curves shown below represent the performance of the neural
%network when being trained with the specified number of hidden neurons.
%Each emotion is represented by a class, as can be seen on each graph: 
%(7=Angry, 1=Disgust, 2=Fear, 3=Happy, 4=Sad, 5=Surprise, 6=Neutral)
%What we are looking for is the ROC curve with the most classes
%located primarily in the upper left hand quadrant of the plot. This will
%indiacte that the neural networks performance, with respect to each
%class, is good.It can be seen that the plot utilizing 250 hidden neurons  
%shows the best ROC curve.
%The final ROC curve is the overall ROC curve for the neural network. 

%% How we got our features. 

% This figure shows what features we use. The LL of the LL using both
% different methods 

imds = imageDatastore({'pic.jpg'});
img = readimage(imds,1);
imshow(img)


sweep = [10,10:10:250];
%% Coif

% Below is the accuracy of the sweep. 
 openfig("../figSaves/1_SweepResult");
 
 %% Confusion Matrix 
 openfig("../figSaves/ConfusionMatrix_1");
 
%% Coif: All ROC 
for i = 1:21 
    formatSpec = "../figSaves/%dN%dRoc";
    savefigpath = sprintf(formatSpec,1,sweep(i));
    openfig(savefigpath);
    
end

sweep = [10,10:10:250];

%% Harr

% Below is the accuracy of the sweep. 
openfig("../figSaves/2_SweepResult");

 %% Confusion Matrix 
 
 openfig("../figSaves/ConfusionMatrix_2");
 

%% Harr: All ROC 
for i = 1:21 
    formatSpec = "../figSaves/%dN%dRoc";
    savefigpath = sprintf(formatSpec,2,sweep(i));
    openfig(savefigpath);
    
end

%% Why Haar is more accurate than Coif4
% When performing our analysis, we came to the conclusion that our Haar
% wavelet was more accurate compared to the Coif wavelet that we used. 
% From our research, we found that Haar is the simplest family of the
% wavelets.  Haar wavelets are memory efficient and they do not have
% overlapping windows, unlike the coiflet family of wavelets.  Those
% wavelets have windows that overlap a lot more.  Haar wavelets only 
% reflect changes between adjacent pixel pairs as well.  Coiflets,
% including the Coif4 wavelet, have more computational overhead.  This
% overhead often leads to smoother wavelets.  Coiflets are pretty similiar
% to Haar wavelets computationally, but Coiflets also use the mirroring
% technique as well.  Because our training images were taken in a controlled
% environent and sudden changes could be detected between them, the Haar
% ended up peforming better in terms of accuracy.  That is what the Haar
% wavelet was designed for.  Coiflets are much better for when an image
% needs to be processed using smoothing and denoising techniques, which was
% not something that was necessarily needed for our training set.

% close all 