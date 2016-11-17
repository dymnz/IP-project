function label = adj_4(image, V, U)

label = zeros(size(image)) + 150;

for i = 1 : size(image, 1)
    for r = 1 : size(image, 2)
        
        if ~(ismember(image(i, r), V) || ismember(image(i, r), U))
            continue;
        end
        
        if (i - 1 == 0 || r - 1 == 0)
            if ismember(image(i, r), V) 
                label(i, r) = 255;
            elseif ismember(image(i, r), U) 
                label(i, r) = 0;
            end
            continue;
        end
        
        if ismember(image(i, r), V)
            if ~ismember(image(i - 1, r), V)  && ...
                    ~ismember(image(i, r - 1), V)
                label(i, r) = 255;
            elseif ismember(image(i - 1, r), V)  && ...
                    ~ismember(image(i, r - 1), V)
                label(i, r) = label(i - 1, r);
            elseif ~ismember(image(i - 1, r), V)  && ...
                    ismember(image(i, r - 1), V)
                label(i, r) = label(i, r - 1);
            elseif ismember(image(i - 1, r), V)  && ...
                    ismember(image(i, r - 1), V) && ...
                    label(i - 1, r) == label(i, r - 1);
                label(i, r) = label(i, r - 1);
            elseif ismember(image(i - 1, r), V)  && ...
                    ismember(image(i, r - 1), V) && ...
                    label(i - 1, r) ~= label(i, r - 1);
                error('This should not happen');
            end
                
            continue;
        end
        
        if ismember(image(i, r), U)
            if ~ismember(image(i - 1, r), U)  && ...
                    ~ismember(image(i, r - 1), U)
                label(i, r) = 0;
            elseif ismember(image(i - 1, r), U)  && ...
                    ~ismember(image(i, r - 1), U)
                label(i, r) = label(i - 1, r);
            elseif ~ismember(image(i - 1, r), U)  && ...
                    ismember(image(i, r - 1), U)
                label(i, r) = label(i, r - 1);
            elseif ismember(image(i - 1, r), U)  && ...
                    ismember(image(i, r - 1), U) && ...
                    label(i - 1, r) == label(i, r - 1);
                label(i, r) = label(i, r - 1);
            elseif ismember(image(i - 1, r), U)  && ...
                    ismember(image(i, r - 1), U) && ...
                    label(i - 1, r) ~= label(i, r - 1);
                error('This should not happen');
            end
                
            continue;
        end
        
            
    end
end
label = uint8(label);
end