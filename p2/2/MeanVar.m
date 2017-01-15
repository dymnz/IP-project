function [Mean, Var] = MeanVar(image, sX, W, sY, H)
    image = double(image);
    Sum = 0;
    for i = sX : sX + W
        for r = sY : sY + H
            Sum = Sum + image(r, i);            
        end
    end
    Mean = Sum / (W*H);

    Diff = 0;
    for i = sX : sX + W
        for r = sY : sY + H
            Diff = Diff + (image(r, i)-Mean)^2;            
        end
    end    
    Var = Diff / (W*H);
    
end

