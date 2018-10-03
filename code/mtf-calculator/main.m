%% Startup
clc;
clear;
format shortg;

%% Set Image Parameters
file_name = 'slit_750um.tif';% input image
pixel_size = 0.055;% mm
region_of_interest = [55,135,19,44];% pixel

%% Process MTF
calculate_mtf( file_name, pixel_size, region_of_interest, false );