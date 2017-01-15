%% Image Filtering
clear; close all;

Imgs = cell(4, 1);
Hists = cell(4, 1);

%% Read
for i = 1 : 4
    Imgs{i} = imread(sprintf('./test2_%d.bmp', i)); 
end

%% Noise
[Mean, Var] = MeanVar(Imgs{1}, 459, 95, 21, 81);
disp(sprintf('1-1: mean:%d dev:%d', round(Mean), round(sqrt(Var))));
[Mean, Var] = MeanVar(Imgs{1}, 272, 79, 280, 59);
disp(sprintf('1-2: mean:%d dev:%d', round(Mean), round(sqrt(Var))));

%% Histogram
Hists = cell(4, 1);
for i = 1 : 4
    Hist = zeros(1, 256);
    for m = 1 : size(Imgs{i}, 1)
        for n = 1 : size(Imgs{i}, 2)
            Hist(Imgs{i}(m, n)+1) = Hist(Imgs{i}(m, n)+1) + 1;
        end
    end
    Hists{i} = Hist;    
end

%% Display Histogram
for i = 1 : 4
    figure; bar(1:256, Hists{i}); 
    axis([1 256 1 1500]);
end

% %% Median Filter
% MedianImgs = cell(4, 1);
% NeighborCount = 1;
% for i = 1 : 4
%     MedianImgs{i} = uint8(MedianFilter(Imgs{i}, NeighborCount));
% end
% %% Display Median Images
% for i = 1 : 4
%     figure; imshow(MedianImgs{i});
% end


% %% Midpoint Filter
% NeighborCount = 1;
% MidpointImgs = cell(4, 1);
% for i = 1 : 4
%     MidpointImgs{i} = uint8(MidpointFilter(Imgs{i}, NeighborCount));
% end
% %% Display Midpoint Images
% for i = 1 : 4
%     figure; imshow(MidpointImgs{i});
% end

% %% AdaptiveMedian Filter
% InitNeighborCount = 1;
% MaxNeighborCount = 3;
% AdaptiveMedianImgs = cell(4, 1);
% for i = 1 : 4
%     AdaptiveMedianImgs{i} = uint8(AdaptiveMedianFilter(Imgs{i}, ...
%         InitNeighborCount, MaxNeighborCount));
% end
% %% Display Midpoint Images
% for i = 1 : 4
%     figure; imshow(AdaptiveMedianImgs{i});
% end

% %% Max Filter
% NeighborCount = 1;
% MaxImgs = cell(4, 1);
% for i = 1 : 4
%     MaxImgs{i} = uint8(MaxFilter(Imgs{i}, NeighborCount));
% end
% %% Display Midpoint Images
% for i = 1 : 4
%     figure; imshow(MaxImgs{i});
% end

% %% Alpha-Trimmed Filter
% NeighborCount = 1;
% D = 2;
% AlphaTrimmedImgs = cell(4, 1);
% for i = 1 : 4
%     AlphaTrimmedImgs{i} = uint8(AlphaTrimmedFilter(Imgs{i}, NeighborCount, D));
% end
% %% Display Midpoint Images
% for i = 1 : 4
%     figure; imshow(AlphaTrimmedImgs{i});
% end

