%script sfig_trans2D.m
%esempio di trasformazione di una figura piana
clear
close all

%apre una figure e disegna gli assi
open_figure(1);
axis_plot(7);

%definisce poligonale FRECCIA-SU e la disegna

P = [
    3 3;
    4 3;
    4 1;
    6 1;
    6 3;
    7 3;
    5 4;
    3 3
    ];

%apre una figure e disegna gli assi
open_figure(1);
%point_plot(P, 'b-', 4);
grid on;
axis_plot(7);

%definisce matrice di rotazione di angolo alpha rispetto ad un punto

%punto di rotazione :
C = [5, 2];
%angolo di rotazione :
a = pi/2;
%traslazione della poligonale verso il centro :
T = get_mat_trasl(-C);
%matrice di rotazione
R = get_mat2_rot(-a);
%traslazione inversa per tornare al punto di partenza :
Tinv = get_mat_trasl(C);

%applica la matrice di rotazione alla poligonale e la disegna
M = Tinv * R * T;
%rappresentazione della trasformazione :
F1 = point_trans_plot(P,M, 'b-', 3);

%determina la matrice SY di trasformazione per simmetria
SY = get_mat2_symm([0,0],[1, 1]);

%applica la matrice di simmetria e disegna
Msim = SY*M;
F2 = point_trans_plot(P, Msim, 'r-', 3);