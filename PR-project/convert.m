img = imread('./pics/2.jpeg');
img = rgb2gray(img);

imwrite(img, '2.jpg');