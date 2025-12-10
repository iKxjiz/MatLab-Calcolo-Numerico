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

%% Metodo delle Secanti :
% main_secmet :
%  questa funzione chiama secmet per il metodo delle secanti
%  e visualizza graficamente la funzione di cui si cercano gli zeri
%  ifun   --> indice della funzione test
%  x0,x1  --> iterati iniziali
%  tol    --> tolleranza richiesta
%  ftrace --> se >0 stampa successione iterati, 0 no

%% ID : 1
%main_secmet(1, 1.725, 1.735, 1e-6, 1);
%% ID 2 :
%main_secmet(2, 0.90, 0.95, 1e-6, 1);
%% ID 3 :
%(prima radice)
%main_secmet(3, 1.90, 1.95, 1e-6, 1); %(iterazioni 6)

%(seconda radice)
%main_secmet(3, 0.9, 0.95, 1e-6, 1);  %(iterazioni 22, più di Newton)

% NOTA : si noti come il numero di iterazioni cambi drasticamente,
% questo perchè per la "prima radice" (radice semplice), l'ordine di
% convergenza del metodo rimane 1.618..., mentre invece per la
% "seconda radice" (radice semplice) l'ordine di convergenza
% del metodo passa da ordine 1.618... a lineare(1).

% radice semplice → ordine di convergenza 1.618...
% radice multipla di molteplicità m>1 → ordine di convergenza lineare (1)

%% ID 4 :
%main_secmet(4, 1.20, 1.22, 1e-6, 1);
%% ID 5 :
%main_secmet(5, -2.015, -2.010, 1e-6, 1); %(prima radice semplice) (ord.conv. = 1.618...)

%main_secmet(5, 0.90, 0.95, 1e-6, 1); %(seconda radice con molteplicità 2) (ord.conv. = 1)
% NOTA : troppe iterazioni (22)
% Questo perchè vicino a una radice multipla, il grafico della funzione
% è molto piatto.
% Le secanti SI TAGLIANO MALE: il punto di intersezione della secante
% con l’asse x avanza "molto lentamente" → ordine 1.

%% ID 6 :
%main_secmet(6, 0.40, 0.45, 1e-6, 1);
%% ID 7 :
%main_secmet(7, 0.90, 0.95, 1e-15, 1);
%% ID 8 :
main_secmet(8, 0.32, 0.35, 1e-6, 1); % (radice con molteplicità due, ord.conv. = 1, numero di iterazioni : 17)
% Anche in questo caso : vicino a una radice multipla, il grafico della
% funzione è molto piatto.
% Le secanti SI TAGLIANO MALE: il punto di intersezione della secante
% con l’asse x avanza "molto lentamente" → ordine 1.


