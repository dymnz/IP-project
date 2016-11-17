clear; close all;

image1 = imread('./test1_1.bmp');
image2 = imread('./test1_2.bmp');

label1 = zeros(size(image1)) + 150;
label2 = zeros(size(image2)) + 150;

V = [0 50 100 150 200];
U = [5 55 105 155 205];

% Using 4-adj on image1 & 2
label1 = adj_4(image1, V, U);
label2 = adj_4(image2, V, U);

figure; imshow(label1);
figure; imshow(label2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

label1x = zeros(size(image1)) + 150;
label2x = zeros(size(image2)) + 150;

% Which is equivalent to this
for i = 1 : 256
    if ismember(i-1, V)
        label1x(image1==(i-1)) = 255;    
        label2x(image2==(i-1)) = 255;    
    elseif ismember(i-1, U)
        label1x(image1==(i-1)) = 0;  
        label2x(image2==(i-1)) = 0;  
    end
end

% Proof
if isempty(find(double(label1x)-double(label1)))
    disp('label1x == label1');
else 
    disp('label1x != label1');
end
if isempty(find(double(label2x)-double(label2)))
    disp('label2x == label1');
else 
    disp('label2x != label1');
end


