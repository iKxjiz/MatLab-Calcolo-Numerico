%esercizio A.1
clear all
clc
%definire A
A = [
    1 2 3 4;
    3 4 5 6;
    5 6 7 8;
    7 8 9 0
    ];
%fare una copia della matrice A e chiamarla B
B = A;

%copiare la prima riga di A in un vettore a
a = A(1, :);

%sostituire la prima riga di A con l'ultima
A(1, :) = A(4, :);

%copiare il vettore a nell'ultima riga di A
A(4, :) = a;

%definire P come la matrice identità 4x4 con la
%prima e quarta riga scambiate

P = [
    0 0 0 1;
    0 1 0 0;
    0 0 1 0;
    1 0 0 0
    ];

%definire C come il prodotto di P per B
C = P*B;

%stampare le matrici A e C e confrontarle
disp(A);
disp(C);

