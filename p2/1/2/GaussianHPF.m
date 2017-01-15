function result = GaussianHPF(Data, D0)
U = size(Data, 1);
V = size(Data, 2);

result = zeros(U, V);
for u = 1 : U
    for v = 1 : V
        D = sqrt((u - U/2)^2 + (v - V/2)^2);
        result(u, v) = Data(u, v) * (1-exp(-D^2/(2*D0^2)));        
    end
end
end