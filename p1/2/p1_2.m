clear; close all;

image1 = imread('./test2_1.jpg');
image2 = imread('./test2_2.bmp');

i1Hist = zeros(1, 256);
i2Hist = zeros(1, 256);
iSpecHist = zeros(1, 256);

gamma = round(gampdf(1:256, 1.5, 20)*100000);

for i = 1 : 8 : 256
    iSpecHist(i) = gamma( max(round(i), 1) );    
end

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

figure; bar(1:256, i1Hist);
figure; bar(1:256, i2Hist);
figure; bar(1:256, iSpecHist);

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

prob = 0;
iSpecTrans = zeros(1, 256);
for i = 1 : 256
    disp(prob);
    prob = prob + iSpecHist(i) / sum(iSpecHist);
    iSpecTrans(i) = (255) * prob;
end

i1Trans = round(i1Trans);
i2Trans = round(i2Trans);
iSpecTrans = round(iSpecTrans);
iSpecInverse = zeros(1, 256);

for i = 1 : 256
    index = 1;
    num = -1;
    for r = 1 : 256
        if iSpecTrans(r) < i - 1
            if num ~= iSpecTrans(r)
                index = r;
                num = iSpecTrans(r);
            end
        elseif iSpecTrans(r) == i - 1
            if num ~= iSpecTrans(r)
                index = r;
            end
            break;
        else
            break
        end       
    end
    iSpecInverse(i) = index-1;
end

for i = 1 : size(image1, 1)
    for r = 1 : size(image1, 2)
        image1(i, r) = iSpecInverse(i1Trans(image1(i, r)+1)+1);
    end
end

for i = 1 : size(image2, 1)
    for r = 1 : size(image2, 2)
        image2(i, r) = i2Trans(image2(i, r)+1);
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






