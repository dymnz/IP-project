function Result = oneDFFT(Data)

M = numel(Data);
C = log2(M);
MaxStage = C;

Outputs = zeros(MaxStage, M);
Outputs(1, :) = Data(FindInputIndex(M));

for stage = 1 : MaxStage
    
    MaxBlocks = 2^(MaxStage - stage);   
    BlockSize = 2^stage;
    
    for block = 0 : MaxBlocks - 1
        MaxOutputs = 2^(stage - 1);
        % Upper        
        for output = 1 : MaxOutputs
            Outputs(stage + 1, block*BlockSize + output) =  ...
                Outputs(stage, block*BlockSize + output) + ...
                Outputs(stage, block*BlockSize + output + BlockSize/2) ...
                * W(-MaxBlocks*(output-1), M);
        end        
        % Bottom
        for output = 1 : MaxOutputs
            Outputs(stage + 1, block*BlockSize + output + BlockSize/2) =  ...
                Outputs(stage, block*BlockSize + output) - ...
                Outputs(stage, block*BlockSize + output + BlockSize/2) ...
                * W(-MaxBlocks*(output-1), M);
        end        
    end
end
Result = Outputs(end, :);
end