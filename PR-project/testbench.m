clear; close all;

testing = true;

files = {'5.jpg'};
clusters = [2 3 4 5];

for i = 1 : numel(files)
    file_name = files{i};
    data_dir = './pics/';
    for r =  1 : numel(clusters)
        n_cluster = clusters(r);
        fprintf('I: %s N: %d\n', file_name, n_cluster);
        fprintf('KM\n');
        KM;
        fprintf('FCM\n');
        FCM;
        fprintf('AFKM\n');
        AFKM;
    end
end

clear;
