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
close all;
clear;
clc;

%% Metodo di Bisezione :
% La function main bisez.m fa uso della function bisez.m che
% implementa il metodo di bisezione.
% Viene effettuato il grafico della funzione f (x) cos`ı
% da poter localizzare visivamente gli zeri della funzione
% nell’intervallo e poter definire l’intervallo di innesco
% del metodo.

%% ID : 1 ==> [1.7,1.8]
%main_bisez(1,1e-6);

%% ID : 2 ==> [0.9, 1.1]
%main_bisez(2,1e-6);

%% ID : 3 ==> radici :
% 1) [1.95, 2.05]
% 2) [0.9, 1.1](due radici coincidenti, ordine di convergenza 1)

%main_bisez(3,1e-6);

%roots([-0.5, 2, -3, 3, -2.5, 1])
% 2.0000 + 0.0000i (radice reale)
% 0.0000 + 1.0000i (radice complessa i)
% 0.0000 - 1.0000i (radice complessa -i)
% 1.0000 + 0.0000i (radice =%
% 1.0000 - 0.0000i  %=con molteplicità due)

%% ID : 4 ==> [1.25, 1.26]

%main_bisez(4, 1e-6);

% NOTA : si noti come al variare della tolleranza variano anche
% il numero di iterazioni del metodo di bisezione per cercare
% le radici.
% Per tolleranze gradi come 1e-1, ci vogliono pochissime iterazione
% ma la precisione della radice è pessima, lo si può vedere graficamente.

%main_bisez(4,1e-1);

% Per tolleranze piccole come 1e-15, il numero di iterazioni aumenta
% di molto così come aumenta di molto la precisione della radice.

%main_bisez(4, 1e-15);

% per valori di tolleranza c'è una nota aggiuntiva, ovvero che :
% dopo un certo punto il numero di iterazioni non aumenta più,
% questo perché il metodo arriva al limite della precisione
% macchina, circa 10e-16 (1e-15).
% non esistono numeri distinti più vicini tra loro di circa (1e-15).
% Il metodo non può più migliorare la l'approssimazione.



%% ID : 5 ==> radici :
% 1) [-2.005, -1.995]
% 2) [0.95,1.05] (radice con molteplicità 2)
%main_bisez(5,1e-6);
%roots([1, 0, -3, 2])

%% ID : 6 ==> [0.495,0.505]
%main_bisez(6,1e-6);

%% ID : 7 ==> [0.995,1.005]
%main_bisez(7,1e-6);

%% ID : 8 ==> [0.35,0.45]
%main_bisez(8,1e-6);
