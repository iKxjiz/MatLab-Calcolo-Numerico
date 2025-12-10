%script sfig_trans2D.m
%esempio di trasformazione di una figura piana
clear all
close all

%apre una figure e disegna gli assi
open_figure(1);
axis_plot(7);

%definisce poligonale FRECCIA-SU e la disegna

F = [4 3; 3 3; 5 4; 7 3; 6 3; 6 1; 4 1; 4 3];
point_plot(F, 'b-', 2.5);

%apre una figure e disegna gli assi
open_figure(2);
axis_plot(7);

%definisce matrice di rotazione di angolo alpha rispetto ad un punto

B = [5, 2];
T = get_mat_trasl(-B);
R = get_mat2_rot(-pi/2);
% Traslazione inversa
Tinv = get_mat_trasl(B);

M = Tinv * R * T;
F1 = point_trans_plot(F,M, 'b-', 1.5);

SY = get_mat2_symm([0,0],[1,1]);
F2 = point_trans_plot(F1, SY, 'r-', 1.5);

%applica la matrice di rotazione alla poligonale e la disegna
%TO DO

%determina la matrice SY di trasformazione per simmetria
%TO DO

%applica la matrice di simmetria e disegna
%TO DO
