function index = FindInputIndex(M)
MaxStage = log2(M);
index = [1:M];
newIndex = zeros(size(index));
for stage  = 0 : MaxStage - 1    
    BlockSize = 2^(MaxStage - stage);   
    BlockNum = 2^stage;
    
    nextBlockSize = BlockSize/2;    

    for block = 0 : BlockNum - 1
        OddPart = index(BlockSize*block+2:2:BlockSize*(block+1));
        EvenPart = index(BlockSize*block+1:2:BlockSize*(block+1)-1);
        newIndex(BlockSize*block+1:BlockSize*block+nextBlockSize) = EvenPart;
        newIndex(BlockSize*block+nextBlockSize+1:BlockSize*block+2*nextBlockSize) = OddPart;
    end

    index = newIndex;
end

end