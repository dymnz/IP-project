%% K-means Clustering Algorithm
clear; close all;

% Parameters
n_cluster = 3;

file_name = '1.jpg';
data_dir = './pics/';

% Read the image
img = imread([data_dir file_name]);

n_row = size(img, 1);
n_col = size(img, 2);

img = im2double(img);
figure;
imshow(img);
%% K-means
% Create random centers
values = unique(img);
random_indices = randperm(length(values));

centers = values(random_indices(1:n_cluster));

% Find minimum distance to center
loop = 0;
while true
    loop = loop + 1;
    old_centers = sort(centers);
    distances = abs( repmat(img, [1, 1, n_cluster])...
        - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

    [val, ind] = min(distances, [], 3);

    % Find new cluster centers
    for i = 1 : n_cluster
        centers(i) = mean(img(ind==i));
    end

    if mean(abs(old_centers - sort(centers))) < 0.000001
        break;
    end

    %
end
disp(loop)

for i = 1 : n_cluster
    img(ind==i) = centers(i);    
end
figure;
imshow(img);