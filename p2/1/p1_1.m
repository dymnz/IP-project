%% FFT and IFFT
clear; close all;

%% Read
oData = ...
[1+j      1        6+0.75j     2     ; ...
 0.5     4-5j       2+3j      1+7j   ; ...
 0.86  2.68-0.8j  0.44+8j      5j    ; ...
 2        7          8j     2.8+0.77j];

%% Zero padding
DataW = size(oData, 2);
DataH = size(oData, 1);
C = ceil(log2(DataW));
D = ceil(log2(DataH));
M = 2^C;
N = 2^D;
Data = zeros(N, M);
Data(1:DataH, 1:DataW) = oData;

%% 2D FFT
FFTResult = twoDFFT(Data);

%% 2D iFFT
ReData = twoIDFFT(FFTResult);

%% Verify
Diff = abs(ReData - Data);
Diff(Diff<1e-5) = 0;
if isempty(find(Diff))
    disp('Correct');
else
    disp('Wrong');
end




