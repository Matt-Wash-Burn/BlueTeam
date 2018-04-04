function stuff = ExtractFeaturesMagic(trainingPixels, wname)
%ExtractFeaturesMagic Extracts the features of the row vector using the
%magnatude components of the fft 
%   Detailed explanation goes here

fim = reshape(trainingPixels, [48,48])'; % row = 48 x 48  image
% imagesc(fim)                                       % show the image
% title(num2str(trainingPixels))               % show the label



% imagesc(sfim); 

%% Frequency componenets from Nick submission 

%% Applying the filters on input images

[cA1,cH1,cV1,cD1] = dwt2(fim,wname);
% W1 = [cA1,cH1,cV1,cD1]; 
[cA2,cH2,cV2,cD2] = dwt2(cA1,wname);
% W2 = [cA2,cH2,cV2,cD2]; 
waveStuff1 = [cA1 cH1 ; cV1 cD1];
waveStuff2 = [cA2 cH2 ; cV2 cD2];

% FV = [cA1 ,cH2,cV2,cD2] ;


stuff = reshape(cA1, [1,size(cA1,1)^2]);
stuff = [stuff reshape(cH2, [1,size(cH2,1)^2])];
stuff = [stuff reshape(cV2, [1,size(cV2,1)^2])];
stuff = [stuff reshape(cD2, [1,size(cD2,1)^2])];

% figure; imagesc(waveStuff1); 
% figure; imagesc(waveStuff2); 

% %% Reshape to return to NN 

% waveStuff2 = imresize(waveStuff2, [24 24]);
% 
% %   var = size(waveStuff2); 
% %  
% %  frameSize = var(1); 




end