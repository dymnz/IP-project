function result = AdaptiveMedianFilter(image, InitNeighborCount, MaxNeighborCount)

[imageH, imageW] = size(image);


result = zeros(size(image));

for r = 1 : imageH
    for c = 1 : imageW
        NeighborCount = InitNeighborCount;
        while true
            WindowSize = (2*NeighborCount+1)^2;
            window = zeros(WindowSize, 1);
            index = 0;
            for m = max(1, r-NeighborCount) : min(imageH, r+NeighborCount)
                for n = max(1, c-NeighborCount) : min(imageW, c+NeighborCount)              
                    index = index + 1;
                    window(index) = image(m, n);
                end
            end
            MaxValue = max(window);
            MinValue = min(window);
            MedValue = median(window);
            CurValue = image(r, c);
            
            if MinValue < MedValue && MedValue < MaxValue
                if MinValue < CurValue && CurValue < MaxValue
                    Value = CurValue;
                else
                    Value = MedValue;
                end
                break;
            elseif NeighborCount + 1 > MaxNeighborCount
                Value = MedValue;  
                break;
            else
                NeighborCount = NeighborCount + 1;
            end
            
        end
        result(r, c) = Value;      
    end
end

end