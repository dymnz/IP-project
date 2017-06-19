%% Adaptive Fuzzy-K-means Clustering Algorithm
clear; close all;

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

img = im2double(img);

%% K-means for initial center
% Create centers
max_v = max(max(img)); 
min_v = min(min(img));

for j = 1 : n_cluster
    centers(j) = min_v + (2*j+1)*(max_v-min_v)/(2*n_cluster);
end
centers = min(centers, 1);

fprintf('Centers:\n');
for j = 1 : n_cluster
    fprintf('%.3f, ', centers(j));
end
fprintf('\n');

%% AFKM
old_centers = centers;

loop = 0;
while true
    memberships = zeros(n_row, n_col, n_cluster);
    loop = loop + 1;
    fprintf('Loop:%d\n', loop);
    % Find new distances
    distances = abs( repmat(img, [1, 1, n_cluster])...
        - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

    % Fix the case where distances(r, c, k) = 0
    for r = 1 : n_row
        for c = 1 : n_col
            for j = 1 : n_cluster
                d_sum = 0;
                for k = 1 : n_cluster
                    if distances(r, c, k)==0
                        break;
                    end
                    d_sum = d_sum + ...
                        (distances(r, c, j)/distances(r, c, k))...
                        .^(2/(fuzziness-1));
                end
                memberships(r, c, j) = d_sum^-1;
                for k = 1 : n_cluster
                    if distances(r, c, k)==0
                        memberships(r, c, :) = zeros([1, 1, n_cluster]);
                        memberships(r, c, k) = 1;
                        break;
                    end
                end                
            end
        end
    end
    
    % Update center
    fprintf('Centers:\n');
    for j = 1 : n_cluster
        centers(j) = sum(sum(memberships(:, :, j).*img(:, :))) ...
                        / sum(sum(memberships(:, :, j)));
        fprintf('%.3f, ', centers(j));
    end
    fprintf('\n');

    delta = mean(abs(old_centers - centers));
    fprintf('delta: %f\n', delta);
    
    if delta < stopping_threshold
        break;
    end

    old_centers = centers;
end    

fprintf('Centers:\n');
for j = 1 : n_cluster
    fprintf('%.3f, ', centers(j));
end
fprintf('\n');

%% Use the maximum membership as class label
% Find new distances
distances = abs( repmat(img, [1, 1, n_cluster])...
    - repmat(reshape(centers, [1, 1, n_cluster]), [n_row n_col 1]) );

% Find membership
for j = 1 : n_cluster
    for k = 1 : n_cluster
        memberships(:, :, j) = memberships(:, :, j) + ...
                    (distances(:, :, j)./distances(:, :, k)) ...
                    .^(2/(fuzziness - 1));            
    end  
    memberships(:, :, j) =  memberships(:, :, j).^-1;
end

% Fix the case where distances(r, c, k) = 0
for r = 1 : n_row
    for c = 1 : n_col
        if distances(r, c, k) == 0
            memberships(c, c, :) = zeros([1, 1, n_cluster]);
            memberships(r, c, k) = 1;
        end
    end
end
[val, ind] = max(memberships, [], 3);
for j = 1 : n_cluster
    img(ind==j) = centers(j);    
end

figure;
imshow(img);


