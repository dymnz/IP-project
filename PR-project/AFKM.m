%% AFKM Matlab
if ~exist('testing', 'var')
    clear; close all;
    data_dir = './pics/';
    file_name = '4.jpg';
    n_cluster = 3;
end

% Parameters
fuzziness = 2;
stopping_threshold = 1e-4;
update_rate = 0.1;

% Read the image
img = im2double(imread([data_dir file_name]));

n_row = size(img, 1);
n_col = size(img, 2);

cc = rand(1, n_cluster);
[Ifc, C, M, oM] = adaptivefuzzycmeans(img, n_cluster,  15, cc);
%%
img = im2double(imread([data_dir file_name]));
values = unique(img);

mems = zeros(length(values), n_cluster);
for i = 1 : length(values)
    for c = 1 : n_cluster
        cM = M(:, :, c);
        ind = find(img==values(i));
        mems(i, c) = cM(ind(1));
    end
end

figure; hold on;
for i = 1 : n_cluster
    plot(values, mems(:, i));
    plot(max(0, C(i)), 0,'o', 'Color', 'r');
end
title('AFKM Membership w/ DoB');

%%
img = im2double(imread([data_dir file_name]));
values = unique(img);

mems = zeros(length(values), n_cluster);
for i = 1 : length(values)
    for c = 1 : n_cluster
        cM = oM(:, :, c);
        ind = find(img==values(i));
        mems(i, c) = cM(ind(1));
    end
end

figure; hold on;
for i = 1 : n_cluster
    plot(values, mems(:, i));
    CI(i) = sum(sum(oM(:, :, i).*img))/sum(sum(oM(:, :, i)));
    plot(CI(i), 0,'o', 'Color', 'g');
end
title('AFKM Membership w/o DoB');
%%
img = im2double(imread([data_dir file_name]));
values = unique(img);

mems = zeros(length(values), n_cluster);
for i = 1 : length(values)
    for c = 1 : n_cluster
        cM = M(:, :, c);
        ind = find(img==values(i));
        mems(i, c) = cM(ind(1));
    end
end

figure; hold on;
for i = 1 : n_cluster
    plot(values, mems(:, i), 'Color', 'r');
end

mems = zeros(length(values), n_cluster);
for i = 1 : length(values)
    for c = 1 : n_cluster
        cM = oM(:, :, c);
        ind = find(img==values(i));
        mems(i, c) = cM(ind(1));
    end
end

for i = 1 : n_cluster
    plot(values, mems(:, i), 'Color', 'g');
end
ylim([-0.2 1])
title('AFKM Membership compare');

for i=1:n_cluster    
    CI(i) = sum(sum(M(:, :, i).*img))/sum(sum(M(:, :, i)));
    plot(max(0, CI(i)), 0,'o', 'Color', 'r');
end
fprintf('M CI');
disp(CI);

for i=1:n_cluster   
    CI(i) = sum(sum(oM(:, :, i).*img))/sum(sum(oM(:, :, i)));
    plot(CI(i), 0,'o', 'Color', 'g');
end
fprintf('oM CI');
disp(CI);


%%
for i = 1 : n_cluster
    img(Ifc==i) = C(i);
end

if ~exist('testing', 'var')
    figure;
    imshow(img);
end
%%
imwrite(img, sprintf('./temp/%s_AFKM_c%d.jpg', file_name, n_cluster));
