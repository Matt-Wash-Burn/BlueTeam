%% Author: Nick DeMarco & Brandon Bench
% Converts an .mp4 file to .avi format

%% Init
clear;
clc;
close all;

%% Load video
v = VideoReader('example.mp4');

%% Convert video to AVI
w = VideoWriter('example.avi', 'Uncompressed AVI');

open(w);

frameNum = v.NumberOfFrames;

for i = 1 : frameNum
    frame = read(v, i);
    writeVideo(w, frame);
end

close(w);