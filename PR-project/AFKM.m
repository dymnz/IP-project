%% FCM Matlab
% clear; close all;

% Parameters
n_cluster = 3;
fuzziness = 2;
stopping_threshold = 1e-4;
update_rate = 0.1;

file_name = '3.jpg';
data_dir = './pics/';

% Read the image
img = imread([data_dir file_name]);

n_row = size(img, 1);
n_col = size(img, 2);

[Ifc, C] = adaptivefuzzycmeans(img, n_cluster, 15);

for i = 1 : n_cluster
    img(Ifc==i) = C(i);
end

figure;
imshow(img);


