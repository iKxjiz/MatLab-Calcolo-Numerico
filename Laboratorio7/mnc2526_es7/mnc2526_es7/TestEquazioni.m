% Si considerino le seguenti funzioni test di cui si vogliono
% determinare gli zeri o radici dell’equazione associata.
% Nella cartella `e presente la function def fun.m che le implementa:
% zfunf01 f (x) = (4x − 7)/(x − 2) x ∈ [1, 1.9]
% zfunf02 f (x) = 1 + 3/x2 − 4/x3 x ∈ [0.5, 6]
% zfunf03 f (x) = 1 − 2.5x + 3x2 − 3x3 + 2x4 − 0.5x5 x ∈ [0, 3]
% zfunf04 f (x) = xn − 2 x ∈ [0, 2] n = 2, 3, 4
% zfunf05 f (x) = x3 − 3x + 2 x ∈ [−2.5, 2]
% zfunf06 f (x) = 1/x − 2 x ∈ (0, 4]
% zfunf07 f (x) = tanh(x − 1) x ∈ [−1, 3]
% zfunf08 f (x) = (1 − x)3 − 13/3(1 − x)2x + 25/4(1 − x)x2 − 3x3 x ∈ [0, 1]
% Si noti che la function def fun.m contiene anche le derivate prime,
% nella forma zfunp0x.

clear all;
clc

% id : 1 ==> [1.6,1.8]
%main_bisez(1,1e-9);

% cambiano da tolleranza faccio più o meno iterazioni

% zfunf03
%roots([-0.5, 2, -3, 3, -2.5, 1])

%% Newton

main_tangmet_ordconv(3,1.9,1e-6,0);
