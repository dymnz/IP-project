C = [ 164.1828 76.1030  210.0554 124.0219    ];

for i = 1 : n_cluster
    img(Ifc==i) = C(i);
end

if ~exist('testing', 'var')
    figure;
    imshow(img);
end

disp(C);

imwrite(img, sprintf('./temp/%s_AFKM2.jpg', file_name));