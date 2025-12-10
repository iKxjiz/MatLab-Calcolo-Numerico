%script sbezcurv2d.m
%carica una curva di Bezier e la disegna
clear
close all

open_figure(1);
axis_plot(12,1.0);

%carica file .db con definizione curva di Bezier
cbez = curv2_bezier_load("c2_bezier.db");

%disegna curva di Bezier
Pxy = curv2_bezier_plot(cbez, 50, 'b-', 1.5);
disp(Pxy)
%disegna poligonale di controllo
point_plot(cbez.cp,'r-o',2,'k','r',8)

%disegna vettori tangenti
curv2_bezier_tan_plot(cbez,3,'g-', 1.5)
