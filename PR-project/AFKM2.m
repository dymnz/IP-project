%% FCM Matlab
if ~exist('testing', 'var')
    clear; close all;
    data_dir = './pics/';
    file_name = '3.jpg';
    n_cluster = 4;
end

% Parameters
fuzziness = 2;
stopping_threshold = 1e-4;
update_rate = 0.1;

% Read the image
img = im2double(imread([data_dir file_name]));

n_row = size(img, 1);
n_col = size(img, 2);

[Ifc, C] = adaptivefuzzycmeans2(img, n_cluster,  15);


for i = 1 : n_cluster
    img(Ifc==i) = C(i);
end

if ~exist('testing', 'var')
    figure;
    imshow(img);
end

disp(C);

imwrite(img, sprintf('./temp/%s_AFKM2_c%d.jpg', file_name, n_cluster));
