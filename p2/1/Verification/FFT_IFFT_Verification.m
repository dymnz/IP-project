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

%% 2D FFT
FFTResult = twoIDFFT(twoDFFT(Data));
MFFTResult = ifft2(fft2(Data));


Diff = abs(MFFTResult - FFTResult);
Diff(Diff<1e-5) = 0;
if isempty(find(Diff))
    disp('Correct');
else
    disp('Wrong');
end


