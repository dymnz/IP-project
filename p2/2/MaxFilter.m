function result = MaxFilter(image, NeighborCount)

[imageH, imageW] = size(image);
WindowSize = (2*NeighborCount+1)^2;

result = zeros(size(image));
window = zeros(WindowSize, 1);
for r = 1 : imageH
    for c = 1 : imageW
        
        index = 0;
        for m = max(1, r-NeighborCount) : min(imageH, r+NeighborCount)
            for n = max(1, c-NeighborCount) : min(imageW, c+NeighborCount)              
                index = index + 1;
                window(index) = image(m, n);
            end
        end
        result(r, c) = max(window);               
    end
end

end