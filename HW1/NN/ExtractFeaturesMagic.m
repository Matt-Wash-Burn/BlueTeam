function stuff = ExtractFeaturesMagic(trainingPixels)
%ExtractFeaturesMagic Extracts the features of the row vector using the
%magnatude components of the fft 
%   Detailed explanation goes here

fim = reshape(trainingPixels, [48,48])'; % row = 48 x 48  image
% imagesc(fim)                                       % show the image
% title(num2str(trainingPixels))               % show the label


sfim = imresize(fim, 0.5);                         % Resize to 24 x 24 img
% imagesc(sfim); 

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

% figure; 
% imshow(abs(re),[I_Mag_min I_Mag_max ]);


%% Extract lower frequencies by just cutting to 16 x 16 
newRe = re(5:20,5:20); 
% figure; imagesc(newRe); 

%% Reshape to return to NN 

stuff = reshape(newRe, [1,256]); 


end
