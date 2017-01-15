%% FFT and IFFT
clear; close all;

%% Read
oData = ...
[1+j      1        6+0.75j     2     ; ...
 0.5     4-5j       2+3j      1+7j   ; ...
 0.86  2.68-0.8j  0.44+8j      5j    ; ...
 2        7          8j     2.8+0.77j];

DataW = size(oData, 2);
DataH = size(oData, 1);

%% Constants
C = ceil(log2(DataW));
D = ceil(log2(DataH));
M = 2^C;
N = 2^D;

%% Zero padding
Data = zeros(N, M);
Data(1:DataH, 1:DataW) = oData;

%% 2D FFT
M = size(Data, 2);
N = size(Data, 1);

colResult = zeros(N, M);
% Column operaion
for col = 1 : N
odData = Data(:, col);
colResult(:, col) = oneDFFT(odData);
end

fftResult = zeros(N, M);
% Row operaion
for row = 1 : N
odData = colResult(row, :);
fftResult(row, :) = oneDFFT(odData);
end



