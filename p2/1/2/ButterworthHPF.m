function result = ButterworthHPF(Data, D0, N)
U = size(Data, 1);
V = size(Data, 2);

result = zeros(U, V);
for u = 1 : U
    for v = 1 : V
        D = sqrt((u - U/2)^2 + (v - V/2)^2);
        result(u, v) = Data(u, v) / ((1+ (D0/D)^(2*N)));        
    end
end
end