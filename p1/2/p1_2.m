clear; close all;

image1 = imread('./test2_1.jpg');
image2 = imread('./test2_2.bmp');

i1Hist = zeros(1, 256);
i2Hist = zeros(1, 256);

for i = 1 : size(image1, 1)
    for r = 1 : size(image1, 2)
        i1Hist(image1(i, r)+1) = i1Hist(image1(i, r)+1) + 1;
    end
end

for i = 1 : size(image2, 1)
    for r = 1 : size(image2, 2)
        i2Hist(image2(i, r)+1) = i2Hist(image2(i, r)+1) + 1;
    end
end

figure; bar(0:255, i1Hist);
figure; bar(0:255, i2Hist);

% Histogram Eqaulization
prob = 0;
i2Trans = zeros(1, 256);
for i = 1 : 256
    prob = prob + i1Hist(i) / numel(image1);
    i1Trans(i) = (255) * prob;
end

prob = 0;
i2Trans = zeros(1, 256);
for i = 1 : 256
    disp(prob);
    prob = prob + i2Hist(i) / numel(image2);
    i2Trans(i) = (255) * prob;
end

for i = 1 : size(image1, 1)
    for r = 1 : size(image1, 2)
        image1(i, r) = round(i1Trans(image1(i, r)+1));
    end
end

for i = 1 : size(image2, 1)
    for r = 1 : size(image2, 2)
        image2(i, r) = round(i2Trans(image2(i, r)+1));
    end
end

figure; imshow(image1);
figure; imshow(image2);

i1Hist = zeros(1, 256);
i2Hist = zeros(1, 256);

for i = 1 : size(image1, 1)
    for r = 1 : size(image1, 2)
        i1Hist(image1(i, r)+1) = i1Hist(image1(i, r)+1) + 1;
    end
end

for i = 1 : size(image2, 1)
    for r = 1 : size(image2, 2)
        i2Hist(image2(i, r)+1) = i2Hist(image2(i, r)+1) + 1;
    end
end

figure; bar(0:255, i1Hist);
figure; bar(0:255, i2Hist);






