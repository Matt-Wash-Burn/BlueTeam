%% Delivery report Pt 2 
% This report contains the awnsers to questions posed in the Delivarble 

%% Deliverable 3ci

% The number of neurons that worked better for step 3  was 400 for a sample
% size of 9000. This number of neurons worked better because increasing the
% number of neurons showed a decrese in accuracy and favorable readings
% from the ROC (Receiver Operating Characteristic). This is most commanly
% because of overfitting to the training set of the data.  


%% Deliverable 3cii

%The extraction method that worked better was the one with less inputs and
%more information. The extraction of the frequency magnatude components
%showed an increased accuraccy at different levels of neurons in the sweep.
%This was because the features that were fed to the input had more
%information in them for the neural network. 

%% Part 3 Training a machine to understand emtion (The Sweep)


%% Part 4 Methods to reduce complexity 



%% Part 5 Sweep ROC


for i = 1:21 
    formatSpec = "./Q5figSaves/N%dRoc";
    savefigpath = sprintf(formatSpec,sweep(i));
    openfig(savefigpath);
    
end
% close all 



