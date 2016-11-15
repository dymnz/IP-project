clear; close all;

image = imread('./test3_1.bmp');
tImage = image;
% figure; imshow(image);

Neighbor = 3;
MaskSize = 2*Neighbor+1;
E = 10;
K = [0.6 0 1];

iHist = zeros(1, 256);
for i = 1 : size(image, 1)
    for r = 1 : size(image, 2)
        iHist(image(i, r)+1) = iHist(image(i, r)+1) + 1;
    end
end
Probs = iHist./numel(image);

GlobalMean = 0;
for i = 1 : 256
    GlobalMean = GlobalMean + Probs(i) * (i - 1);
end

GlobalVar = 0;
for i = 1 : 256
    GlobalVar = GlobalVar + Probs(i) * ((i - 1) - GlobalMean)^2;
end
C = 0;
for i = 1+Neighbor : size(image, 1)-Neighbor
    for r = 1+Neighbor : size(image, 2)-Neighbor
        
        LocalSum = 0;
        for m = -Neighbor : Neighbor
            for n = -Neighbor : Neighbor
                LocalSum = LocalSum + double(image(i+m, r+n));
            end
        end
        LocalMean = LocalSum / (MaskSize^2);
        
        LocalVar = 0;
        for m = -Neighbor : Neighbor
            for n = -Neighbor : Neighbor
                LocalVar = LocalVar + ...
                    (double(image(i+m, r+n)) - double(LocalMean))^2;
            end
        end    
        LocalVar = LocalVar / (MaskSize^2);
        
        if LocalMean <= K(1)*GlobalMean ...
            && (K(2)*GlobalVar <= LocalVar && LocalVar <= K(3)*GlobalVar)
            tImage(i, r) = E*image(i, r);
            C = C + 1;
        end
        
    end
end

figure; imshow(tImage);

