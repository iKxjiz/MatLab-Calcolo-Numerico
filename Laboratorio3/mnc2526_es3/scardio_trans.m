%script scardio_trans.m
%Disegno della curva cardioide e sue rotazioni
clear
close all

%apre figure
figure('Position', [10 10 500 400])
open_figure(1);
%disegna gli assi
axis_plot(2)

%intervallo di definizione curva
a=0;
b=2*pi;
%numero punti di valutazione/disegno
np=150;
%disegna curva
[x,y]=curv2_plot('c2_cardioide',a,b,np,'b-',1.5);
%crea matrice dei punti della curva
P=[x',y'];

%apre nuova figure
open_figure(2);

%definisce vettore di colori
vcol=['r','g','b','c','m','y','k'];

%definisce numero di rotazioni da effettuare
ncurv=...;

%definisce angolo e matrice di rotazione
theta=...;
R=...;

%disegno delle curve ognuna ruotata e con colore differente
for i=1:ncurv
    col=vcol(mod(i,7)+1);
    P=point_trans_plot(...);
end

