% Author: Abdallah S. Abdallah aua639@psu.edu
% HW2_template.m - Version: 0.2


clear;
clc;
close all; % closes all figures
testing =0;
%% Load the dataset
if testing == 1
    tic
    load Part1.mat
    toc
else
    
    
    % Find the feature file
    filename = '../../DontCommit/fer2013.csv';
    
    
    % I already used Matlab GUI to generatre the function
    % (importfileAsColVectors) and uploaded it to the homework folder as well
    [emotion,pixels,Usage] = importfileAsColVectors(filename,2, 35888 );
    
    pixelsChars = char(pixels);
    
    
    
    
    %% ToDO by students: repeat partitionin and processing until you extract all data pixels
    tic
    pixelsData_chunk1 = str2num(pixelsChars(1:10000,:));
    toc
    
    tic
    pixelsData_chunk2 = str2num(pixelsChars(10001:20000,:));
    toc
    
    tic
    pixelsData_chunk3 = str2num(pixelsChars(20001:30000,:));
    toc
    
    tic
    pixelsData_chunk4 = str2num(pixelsChars(30001:35887,:));
    toc
    
    
    %% Load the saved .mat files
    % tic
    %
    % load emotions.mat
    % load Usage.mat
    % load pix1.mat
    % load pix2.mat
    % load pix3.mat
    % load pxi4.mat
    % toc
    
    
    %% ToDO by students: repeat partitionin and processing until you extract all data pixels
    
    %% ToDO by students:use matlab syntax to combine the pixels data
    %% be smart and save the pixels data as well before you actually use it for
    %% wavelets calculations, so that if you suffer any crashes, you never need
    %% to rerun the .csv reading and parsing code again
    
    pix = [pixelsData_chunk1 ; pixelsData_chunk2 ; pixelsData_chunk3 ; pixelsData_chunk4];
end
%
% load emotions.mat
%% ToDO by students:Loop over each row to execute
% restructure each row into 2D Image matrix
% apply wavelet analysis to level 1
% repeat wavelet analysis as you desire
% choose and combine the wavelets coefficients that you like
% concatenate the chosen subset of coefficients into single row format

frameSize = [24 24];
t1 =tic; 
% newTrainingPixCoif = double(pix(:,1:(frameSize(1)*frameSize(1))));
% newTrainingPixHaar = double(pix(:,1:(frameSize(2)*frameSize(2))));
for q = 1: size(pix, 1)

%     if testing == 0
%         newTrainingPixCoif(q,1:end) = ExtractFeaturesMagic(pix(q,1:end), 'coif4');
%     end
    
    
    if q == 1
        var1 = ExtractFeaturesMagic(pix(q,1:end), 'haar');
        var2 = ExtractFeaturesMagic(pix(q,1:end), 'coif4');
        newTrainingPixHaar = double(pix(:,1:(size(var1,2))));
        newTrainingPixCoif = double(pix(:,1:(size(var2,2))));
        newTrainingPixHaar(q,1:end) = var1;
        newTrainingPixCoif(q,1:end) = var2;
    else
        newTrainingPixHaar(q,1:end) = ExtractFeaturesMagic(pix(q,1:end), 'haar');
        newTrainingPixCoif(q,1:end) = ExtractFeaturesMagic(pix(q,1:end), 'coif4');
    end

end
toc(t1)

% if testing == 0
%     
%     figure    ;                                      % plot images
%     colormap(gray)                                  % set to grayscale
%     for i = 1:25                                    % preview first 25 samples
%         subplot(5,5,i)                              % plot them in 6 x 6 grid
%         digit = reshape(newTrainingPixCoif(i, 1:end), [sqrt(size(var1,2)),sqrt(size(var1,2))])';    % row = 28 x 28 image
%         imagesc(digit)                              % show the image
%         title(num2str(emotion(i)))                    % show the label
%     end
%     
% end

% figure    ;                                      % plot images
% colormap(gray)                                  % set to grayscale
% for i = 1:25                                    % preview first 25 samples
%     subplot(5,5,i)                              % plot them in 6 x 6 grid
%     digit = reshape(newTrainingPixHaar(i, 1:end), [sqrt(size(var1,2)),sqrt(size(var1,2))])';    % row = 28 x 28 image
%     imagesc(digit)                              % show the image
%     title(num2str(emotion(i)))                    % show the label
% end

%% ToDO by students: after loopoing , save the wavelets data structure as a preprocessed
% dataaset so that you can also use it in future without going through
% all previous steps again
if testing == 1
    
    %do Nothing
    
else
    save('Part1.mat')
    
end
%% ToDO by students: Now continue the homework on your own, you should not
% need more guidance