clear; close all;

file_name = '3.jpg';
data_dir = './pics/';
n_cluster = 4;

testing = true;


fprintf('Starting KM\n');
KM;
fprintf('Starting FCM\n');
FCM;
fprintf('Starting AFKM\n');
AFKM;

clear;