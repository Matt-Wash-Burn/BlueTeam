%% Author: Nick DeMarco & Brandon Bench
% Splits .avi video into frames for object classification

%% Init
clear;
clc;
close all;

%% Load video
v = VideoReader('example.avi');

% Get video information
numFrames = v.NumberOfFrames;
vidHeight = v.Height;
vidWidth = v.Width;

%% Split video
frameArray = cell(numFrames, 1);

for f = 1 : numFrames
    % get current frame
    frameArray{f} = read(v, f);
    
    % display frame
    hImage = plot(2, 2);
	image(frameArray{f});
    caption = sprintf('Frame %4d of %d.', f, numFrames);
    title(caption);
    drawnow;
end

%% Save frames
save('vidFrames', 'frameArray', '-v7.3');


    
    
