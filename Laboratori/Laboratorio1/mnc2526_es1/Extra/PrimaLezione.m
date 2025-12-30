%% Livello 1 - Base

% Esercizio 1 - Prime operazioni
clear all
clc

A = [2 4; 6 8];
B = [1 3; 5 7];
v = [2; 3];

disp(A + B);
disp(3*A);
disp(A*v);
disp(A');

% Esercizio 1.2 - Operazioni elemento per elemento
clear all
clc

X = [1 2 3; 4 5 6];
Y = [2 2 2; 3 3 3];

% Calcola:
% a) X.*Y
% b) X.^2
% c) X./Y
% d) (X+Y).^2

% X e Y devono avere le stesse dimensioni
disp(X.*Y);
disp(X.*2);
disp(X./Y);
disp(X+Y);
disp((X+Y).*2);

% Esercizio 1.3 - Vettori
clear all
clc
a = [1 2 3 4];
b = [2 3 4 5];

% Calcola:
% a) a.*b (prodotto elemento per elemento)
% b) a*b' (prodotto scalare)
% c) a'.^2
% d) sum(a.*b) e confrontalo con a*b'

disp(a.*b);
disp(a*b'); % NON posso fare invece disp(a*b)
disp(a'.^2); % NON posso fare invece disp(a'^2);
disp(a.^2);

% Notiamo ora le differenze fra queste due operazioni :
disp(sum(a.*b)); % Fa la somma della moltiplicazioni degli elementi : 40
disp(sum(a.*b'));
% a.*b' = [1 2 3 4] .* [2]
%                      [3]
%                      [4]
%                      [5]
%
% Risultato: matrice 4x4
%= [1×2  2×2  3×2  4×2 ]   [2   4   6   8 ]
%  [1×3  2×3  3×3  4×3 ] = [3   6   9  12 ]
%  [1×4  2×4  3×4  4×4 ]   [4   8  12  16 ]
%  [1×5  2×5  3×5  4×5 ]   [5  10  15  20 ]

disp(size(a)); % Per vedere la dimensione del vettore a
disp(size(b)); % Per vedere la dimensione del vettore b

%% Livello 2 - Intermedio

% Esercizio 2.1 - Sistema lineare semplice
clear all
clc

% Risolvi il sistema:
% 3x + 2y = 12
% x - y = 1
%
% Suggerimento: crea la matrice A e il vettore b, poi usa A\b
% Verifica la soluzione con A*x

A = [3 2; 1 -1];
b = [12; 1];

disp(A\b);
disp(A*(A\b)); % Questa è la verifica A * x = B (Vero!)

% Esercizio 2.2 - Combinazione di operazioni
clear all
clc

% Data:
M = [1 2 3; 4 5 6; 7 8 9];

% Calcola:
% a) La somma di tutti gli elementi (usa sum due volte o sum(sum(M)))
% b) M*M' (matrice per la sua trasposta)
% c) M'*M (trasposta per matrice)
% d) Nota la differenza di dimensioni tra b) e c)

disp(sum(M));
% Questo stampa un vettore dove il singolo elemento è la somma di una colonna della matrice
disp(sum(sum(M)));
%Questo fa la somma anche degli elementi del vettore ottenuto, in questo modo ottengo
%la somma di tutti gli elementi della matrice

disp(M*M'); % Questo fa la classica moltiplicazione di matrici
% (LE DIMENSIONI DEVONO ESSERE RISPETTATE)

disp(M'*M)

% Esercizio 2.3 - Prodotto matriciale vs elemento per elemento
clear all
clc

% Date:
P = [1 2; 3 4];
Q = [2 0; 1 3];

% Calcola e confronta:
% a) P*Q (prodotto matriciale)
% b) P.*Q (prodotto elemento per elemento)
% c) Q*P (prodotto matriciale nell'altro ordine)
% d) Q.*P (elemento per elemento nell'altro ordine)
% e) Quali sono commutativi?



