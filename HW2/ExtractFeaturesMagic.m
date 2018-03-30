function stuff = ExtractFeaturesMagic(trainingPixels, wname, frameSize)
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

[cA2,cH2,cV2,cD2] = dwt2(cA1,wname);

waveStuff1 = [cA1 cH1 ; cV1 cD1]; 
waveStuff2 = [cA2 cH2 ; cV2 cD2]; 





% figure; imagesc(waveStuff1); 
% figure; imagesc(waveStuff2); 
% 
% 
% tic
% toc

% 
% %% Calculating plotting limits
% I_Mag_min = min(min(abs(restoredP1)));
% I_Mag_max = max(max(abs(restoredP1)));
% 
% % figure; 
% % imshow(abs(re),[I_Mag_min I_Mag_max ]);
% 
% 
% %% Extract lower frequencies by just cutting to 16 x 16 
% newRe = re(5:20,5:20); 
% % figure; imagesc(newRe); 
% 
% %% Reshape to return to NN 
% 
waveStuff2 = imresize(waveStuff2, .5);

var = size(waveStuff2); 

frameSize = var(1); 

stuff = reshape(waveStuff2, [1,(frameSize*frameSize)]); 


end