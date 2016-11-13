clear; close all;

image1 = imread('./test1_1.bmp');
image2 = imread('./test1_2.bmp');

V = [0 50 100 150 200];
U = [5 55 105 155 205];

for i = 1 : 255
    if ismember(i, V)
        image1(image1==i) = 255;
        image2(image2==i) = 255;
    elseif ismember(i, U)
        image1(image1==i) = 0;
        image2(image2==i) = 0;
    else
        image1(image1==i) = 150;
        image2(image2==i) = 150;
    end
end

figure; imshow(image1);
figure; imshow(image2);
