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

%% Metodo di Newton e Ordine di convergenza :

%main_tangmet_ordconv :
%  questa function chiama tangmet per il metodo di Newton
%  o delle tangenti e visualizza graficamente la funzione
%  di cui si cercano gli zeri
%  ifun   --> indice della funzione test
%  x0     --> iterato iniziale
%  tol    --> tolleranza richiesta
%  ftrace --> se >0 produce stampe informative

%% ID 1 :
%main_tangmet_ordconv(1, 1.745, 1e-6, 1);
%% ID 2 :
%main_tangmet_ordconv(2, 0.95, 1e-6, 1);
%% ID 3 :
%(prima radice)
%main_tangmet_ordconv(3, 1.95, 1e-6, 1); %(iterazioni 4)

%(seconda radice)
%main_tangmet_ordconv(3, 0.9, 1e-6, 1);  %(iterazioni 17)

% NOTA : si noti come il numero di iterazioni cambi drasticamente,
% questo perchè per la "prima radice" (radice semplice), l'ordine di
% convergenza di Newton rimane quadratico, mentre invece per la
% "seconda radice" (radice semplice) l'ordine di convergenza
% del metodo passa da ordine quadratico a lineare, cioè da 1 a 2.

% radice semplice → ordine di convergenza quadratico (2)
% radice multipla di molteplicità m>1 → ordine di convergenza lineare (1)

%% ID 4 :
%main_tangmet_ordconv(4, 1.25, 1e-6, 1);
%% ID 5 :
%main_tangmet_ordconv(5, -2.005, 1e-6, 1); %(prima radice semplice) (ord.conv. = 2)
%main_tangmet_ordconv(5, 0.95, 1e-6, 1); %(seconda radice con molteplicità 2) (ord.conv. = 1)
%% ID 6 :
main_tangmet_ordconv(6, 0.45, 1e-6, 1);
%% ID 7 :
%main_tangmet_ordconv(7, 0.95, 1e-15, 1);
%% ID 8 :
main_tangmet_ordconv(8, 0.35, 1e-6, 1); % (radice con molteplicità due, ord.conv. = 1, numero di iterazioni : 17)

% NOTA : per zeri (radici) multipli, le ultimo colonne cambiano drasticamente.
% Nel metodo di Newton il comportamento delle quantità |ek+1|/|ek| e ek+1|/|ek|^2,
% cambia in modo significativo a seconda che la radice sia semplice oppure multipla.
% Se la radice x* è semplice, allora Newton converge quadraticamente: l’errore soddisfa
% approssimativamente ∣ek+1∣≈C∣ek∣^2 (l’errore del metodo di Newton alla prossima
% iterazione è (circa) il quadrato dell’errore attuale).
% Di conseguenza, nella tabella si osserva che ek+1|/|ek|^2 tende a un valore finito
% e non nullo (la costante C), mentre |ek+1|/|ek| tende rapidamente a zero, perché
% l’errore cala come il quadrato dell’errore precedente.
% Se invece la radice ha molteplicità m>1, la convergenza di Newton non è più
% quadratica ma solo lineare. In questo caso, la quantità ek+1|/|ek| tende a un
% valore costante compreso tra 0 e 1 (ad esempio 1/2 per una radice doppia),
% confermando la natura lineare della convergenza; al contrario, ek+1|/|ek|^2
% esplode e tende a valori molto grandi, perché il numeratore e il denominatore
% non sono più dello stesso ordine: l’errore non diminuisce come il quadrato,
% ma soltanto come un multiplo lineare dell’errore precedente.
