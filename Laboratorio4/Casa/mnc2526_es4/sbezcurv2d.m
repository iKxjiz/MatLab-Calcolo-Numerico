%script sbezcurv2d.m
%carica una curva di Bezier e la disegna
clear
close all

open_figure(1);
axis_plot(12,1.0);

%carica file .db con definizione curva di Bezier
cbez = curv2_bezier_load('c2_bezier.db');
% NOTA : cbez è la "structure" di una curva 2D di Bèzier
disp(cbez);
%visualizza struttura dati della curva
% cbez.deg : campo scalare per il grado
% cbez.cp : campo array per i punti di controllo (array (n+1)x2)
% cbez.ab : campo array per intervallo di definizione (array di 2)

%disegna curva di Bezier
curv2_bezier_plot(cbez, 100, 'b', 2);

%disegna poligonale di controllo
point_plot(cbez.cp,'r-o',2,'k','r',8)

%disegna vettori tangenti : negli estremi e nel punto centrale
curv2_bezier_tan_plot(cbez, 3, 'g', 2);
