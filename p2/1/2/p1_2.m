%% Homomorphic Filtering
clear; close all;

%% Read
Img = imread('./test1_2.bmp');

%% Zero padding
DataW = size(Img, 2);
DataH = size(Img, 1);
C = ceil(log2(DataW));
D = ceil(log2(DataH));
M = 2^C;
N = 2^D;
Data = zeros(N, M);
Data(1:DataH, 1:DataW) = Img;

%% Centering
for m = 1 : M
    for n = 1 : N
        Data(n, m) = Data(n, m)*(-1)^(m+n);
    end
end

%% 2D FFT
FFTResult = twoDFFT(Data);

%% Ideal HPF
D0 = 10;
HPFResult = IdealHPF(FFTResult, D0);
IHPFImg10 = real(twoIDFFT(HPFResult));
IHPFImg10 = IHPFImg10(1:DataH, 1:DataW);
D0 = 120;
HPFResult = IdealHPF(FFTResult, D0);
IHPFImg120 = real(twoIDFFT(HPFResult));
IHPFImg120 = IHPFImg120(1:DataH, 1:DataW);

%% Gaussian HPF
D0 = 10;
HPFResult = GaussianHPF(FFTResult, D0);
GaussianHPFImg10 = real(twoIDFFT(HPFResult));
GaussianHPFImg10 = GaussianHPFImg10(1:DataH, 1:DataW);
D0 = 120;
HPFResult = GaussianHPF(FFTResult, D0);
GaussianHPFImg120 = real(twoIDFFT(HPFResult));
GaussianHPFImg120 = GaussianHPFImg120(1:DataH, 1:DataW);

%% Butterworth HPF
D0 = 10;
N = 2;
HPFResult = ButterworthHPF(FFTResult, D0, N);
ButterWorthHPFImg10_2 = real(twoIDFFT(HPFResult));
ButterWorthHPFImg10_2 = ButterWorthHPFImg10_2(1:DataH, 1:DataW);
D0 = 120;
N = 2;
HPFResult = ButterworthHPF(FFTResult, D0, N);
ButterWorthHPFImg120_2 = real(twoIDFFT(HPFResult));
ButterWorthHPFImg120_2 = ButterWorthHPFImg120_2(1:DataH, 1:DataW);
D0 = 10;
N = 50;
HPFResult = ButterworthHPF(FFTResult, D0, N);
ButterWorthHPFImg10_50 = real(twoIDFFT(HPFResult));
ButterWorthHPFImg10_50 = ButterWorthHPFImg10_50(1:DataH, 1:DataW);
D0 = 120;
N = 50;
HPFResult = ButterworthHPF(FFTResult, D0, N);
ButterWorthHPFImg120_50 = real(twoIDFFT(HPFResult));
ButterWorthHPFImg120_50 = ButterWorthHPFImg120_50(1:DataH, 1:DataW);

%% Centering
for m = 1 : DataW
    for n = 1 : DataH
        IHPFImg10(n, m) = IHPFImg10(n, m)*(-1)^(m+n);
        IHPFImg120(n, m) = IHPFImg120(n, m)*(-1)^(m+n);    
        GaussianHPFImg10(n, m) = GaussianHPFImg10(n, m)*(-1)^(m+n);
        GaussianHPFImg120(n, m) = GaussianHPFImg120(n, m)*(-1)^(m+n);  
        ButterWorthHPFImg10_2(n, m) = ButterWorthHPFImg10_2(n, m)*(-1)^(m+n);
        ButterWorthHPFImg120_2(n, m) = ButterWorthHPFImg120_2(n, m)*(-1)^(m+n);          
        ButterWorthHPFImg10_50(n, m) = ButterWorthHPFImg10_50(n, m)*(-1)^(m+n);
        ButterWorthHPFImg120_50(n, m) = ButterWorthHPFImg120_50(n, m)*(-1)^(m+n);   
    end
end

%% Back to integer
IHPFImg10 = uint8(IHPFImg10);
IHPFImg120 = uint8(IHPFImg120);
GaussianHPFImg10 = uint8(GaussianHPFImg10);
GaussianHPFImg120 = uint8(GaussianHPFImg120);
ButterWorthHPFImg10_2 = uint8(ButterWorthHPFImg10_2);
ButterWorthHPFImg120_2 = uint8(ButterWorthHPFImg120_2);
ButterWorthHPFImg10_50 = uint8(ButterWorthHPFImg10_50);
ButterWorthHPFImg120_50 = uint8(ButterWorthHPFImg120_50);

%% Output
imwrite(IHPFImg10, '../IHPFImg10.bmp') ;
imwrite(IHPFImg120, '../IHPFImg120.bmp');
imwrite(GaussianHPFImg10, '../GaussianHPFImg10.bmp') ;
imwrite(GaussianHPFImg120, '../GaussianHPFImg120.bmp');
imwrite(ButterWorthHPFImg10_2, '../ButterWorthHPFImg10_2.bmp') ;
imwrite(ButterWorthHPFImg120_2, '../ButterWorthHPFImg120_2.bmp');
imwrite(ButterWorthHPFImg10_50, '../ButterWorthHPFImg10_50.bmp') ;
imwrite(ButterWorthHPFImg120_50, '../ButterWorthHPFImg120_50.bmp');