%% Adaptive Fuzzy-K-means Clustering Algorithm
clear; close all;

% Parameters
n_cluster = 4;
fuzziness = 2;
stopping_threshold = 1e-9;
update_rate = 0.1;

file_name = '2.jpg';
data_dir = './pics/';

% Read the image
img = imread([data_dir file_name]);

n_row = size(img, 1);
n_col = size(img, 2);

img = im2double(img);

figure;
imshow(img);

%% K-means for initial center
% Create random centers
values = unique(img);
random_indices = randperm(length(values));

centers = values(random_indices(1:n_cluster));

% Find minimum distance to center
distances = abs( repmat(img, [1, 1, n_cluster])...
    - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

[val, ind] = min(distances, [], 3);

% Find new cluster centers
for i = 1 : n_cluster
    centers(i) = mean(img(ind==i));
end

%imshow(ind/n_cluster);

%% AFKM
memberships = zeros(n_row, n_col, n_cluster);
old_belongingness = zeros(n_row, n_col, n_cluster);
old_centers = sort(centers);

loop = 0;
while true
    loop = loop + 1;
    % Find new distances
    distances = abs( repmat(img, [1, 1, n_cluster])...
        - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

    % Find membership
    for j = 1 : n_cluster
        for k = 1 : n_cluster
            memberships(:, :, j) = (distances(:, :, j)./distances(:, :, k))...
                        .^(-2/(fuzziness - 1));                
        end   
    end

    % When dk = 0, membership = inf
    if ~isempty(find(isinf(memberships)))
        disp('woah');
        memberships(isinf(memberships)) = 1;
    end

    % Find belongingness
    for j = 1 : n_cluster
        belongingnesses(:, :, j) = centers(i).*memberships(:, :, j);
    end

    % Find error term
    e = belongingnesses - old_belongingness;

    % Update membership
    for j = 1 : n_cluster
        memberships(:, :, j) = memberships(:, :, j) + ...
                update_rate * centers(j) * e(:, :, j);
    end


    % Update center
    for j = 1 : n_cluster
        centers(j) = sum(sum(memberships(:, :, j).*img(:, :))) ...
                        / sum(sum(memberships(:, :, j)));
    end

    if mean(abs(old_centers - sort(centers))) < stopping_threshold
        break;
    end
    
    old_centers = sort(centers);
    old_belongingness = belongingnesses;
end    


% Use K-means to find the result
distances = abs( repmat(img, [1, 1, n_cluster])...
    - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

[val, ind] = min(distances, [], 3);

for i = 1 : n_cluster
    img(ind==i) = centers(i);    
end

loop

figure;
imshow(img);


