clear; close all;

image = imread('./test4_2.bmp');
oimage = imread('./test4_1.bmp');

P1 = [400 0]; 
P2 = [400 600];
X = [P1.' P2.'];

PT1 = [400 90];
PT2 = [710 690];
B = [PT1.' PT2.'];

A = B * inv(X);

transImage = zeros(size(400, 600));
for i = 1 : 400
    for r = 1 : 600
        tP = round(max(A*[i ; r], 1));
        transImage( i, r) = image( min(tP(1), size(image, 1)),...
            min(tP(2), size(image, 2)));
    end
end

subImage = double(transImage) - double(oimage);
figure;imshow(uint8(transImage));
figure;imshow(uint8(subImage));
