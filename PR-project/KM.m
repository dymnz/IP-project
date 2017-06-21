%% K-means Clustering Algorithm
if ~exist('testing', 'var')
    clear; close all;
    data_dir = './pics/';
    file_name = '3.jpg';
    n_cluster = 4;
end

% Parameters
stopping_threshold = 1e-4;


% Read the image
img = imread([data_dir file_name]);

n_row = size(img, 1);
n_col = size(img, 2);

img = im2double(img);


%% K-means
% Create centers
max_v = max(max(img)); 
min_v = min(min(img));

centers = zeros(n_cluster, 1);
for j = 1 : n_cluster
    centers(j) = min_v + (2*j+1)*(max_v-min_v)/(2*n_cluster);
end
centers = min(centers, 1);

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
    
    delta = mean(abs(old_centers - sort(centers)));
%     fprintf('delta: %f\n', delta);
    
    if mean(abs(old_centers - sort(centers))) < stopping_threshold
        break;
    end

end



distances = abs( repmat(img, [1, 1, n_cluster])...
    - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

[val, ind] = min(distances, [], 3);

for i = 1 : n_cluster
    img(ind==i) = centers(i);    
end

if ~exist('testing', 'var')
    figure;
    imshow(img);
end

disp(255*centers');

imwrite(img, sprintf('./temp/%s_KM_c%d.jpg', file_name, n_cluster));