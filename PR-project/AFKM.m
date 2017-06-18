%% Adaptive Fuzzy-K-means Clustering Algorithm
clear; close all;

% Parameters
n_cluster = 4;
fuzziness = 2;

file_name = '1.jpg';
data_dir = './pics/';

% Read the image
img = imread([data_dir file_name]);

n_row = size(img, 1);
n_col = size(img, 2);

img = im2double(img);

%% K-means for initial center
% Create random centers
values = unique(img);
random_indices = randperm(length(values));

centers = values(random_indices(1:n_cluster));

% Find minimum distance to center
distances = abs( repmat(img, [1, 1, n_cluster])...
    - repmat(reshape(centers, [1, 1, 4]), [n_row n_col 1]) );

[val, ind] = min(distances, [], 3);

% Find new cluster centers
for i = 1 : n_cluster
    centers(i) = mean(img(ind==i));
end

%imshow(ind/n_cluster);
