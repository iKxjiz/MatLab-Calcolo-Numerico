%script sppbezierinterp_curve2d.m
%Interpolazione con curva cubica a tratti C^1 di Hermite (interpolazione di
%valori e derivate) di una curva in forma parametrica (cp2_circle.m)
clear
close all

col=['r','g','b','k'];
open_figure(1);

%Punti della curva da interpolare; parametri equispaziati
m=6;
a=0;
b=2*pi;
tpar=linspace(a,b,m);
%campiona valori e derivate (punti e tangenti)
[xp,yp,xp1,yp1]=cp2_circle(tpar);
Q=[xp',yp'];
Q1=[xp1',yp1'];

%disegna i punti da interpolare
point_plot(Q,'k:o',1,'k');
curv2_plot('cp2_circle', a,b,100,'r',1);

%chiama function curv2_ppbezierCC1_interp_der per interpolare
ppP=curv2_ppbezierCC1_interp_der(Q,Q1,tpar);

np=50;
Px = curv2_ppbezier_plot(ppP,np, 'b',2);

% disegna la curva interpolante a tratti
%1.punti equispaziati per test sull'errore


%2.valuta curva interpolante e la disegna
%TO DO

%3.valuta curva analitica e la disegna
%TO DO

%4.calcola l'errore di interpolazione (distanza euclidea fra i punti
%della curva analitica e della curva cubica di Bézier a tratti
%interpolante) e considera il valore massimo
%TO DO


%salva su file la curva a tratti generata per interpolazione
% curv2_ppbezier_save('c2_ppbez_circ.db',ppP);

