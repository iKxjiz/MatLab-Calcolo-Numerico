%script slung_bezier.m
%calcolo della lunghezza di una curva 2D di Bezier
clear
close all

open_figure(1);
axis_plot(2.5,0.25);

%definizione di una curva di Bézier
a=0; b=1;
bezP.cp=[0,1;1,2;2,1;1,0];
bezP.deg=length(bezP.cp(:,1))-1;
bezP.ab = [a b];

%disegno della curva e suoi punti di controllo
curv2_bezier_plot(bezP,40,'b',2);
point_plot(bezP.cp,'k-o',1);

%calcolo lunghezza della curva e sua stampa
val = curv2_bezier_len(bezP);
fprintf('Lunghezza della curva: %e\n',val); 