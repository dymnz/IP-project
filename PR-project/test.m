A = cat(3, cat(3, 1*magic(3), 2*magic(3)), 3*magic(3))

C = cat(3, cat(3, magic(3), magic(3)), magic(3))

for i=1:3
    B(:,:,i)=C(:,:,i).*A;
end