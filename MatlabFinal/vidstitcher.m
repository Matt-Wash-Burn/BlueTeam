%% Author: Nick DeMarco & Brandon Bench
% Stitched annotated frames into video

%% Init
clear;
clc;
close all;

%% Load video frames
load vidFrames.mat;

%% Create video writer
w = VideoWriter('exampleAnnotated.avi', 'Uncompressed AVI');

numFrames = size(frameArray);

%% Stitch video
open(w);

for i = 1 : numFrames
    writeVideo(w, frameArray{i});
end

close(w);