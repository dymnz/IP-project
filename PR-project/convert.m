img = imread('./pics/1.png');
img = rgb2gray(img);

imwrite(img, '1.jpg');