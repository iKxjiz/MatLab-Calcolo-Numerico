%script di prova per disegno di una funzione come curva

clear
close all

%apre una figure e disegna gli assi
% figure('Position', [10 10 500 400])
open_figure(1);
axis_plot(6.7,0.25,1.5)
% axis normal

%intervallo di definizione e numero punti da valutare
a=0;
b=2*pi;
np=150;

curv2_plot('mysin',a,b,np,'b-',2);

curv2_plot('mycos',a,b,np,'r-',2);