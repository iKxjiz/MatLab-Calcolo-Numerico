% script spolint_lagr_dati.m
% Interpolazione polinomiale di un set di dati nella forma di Lagrange;
% viene prodotto il grafico del data set e del polinomio interpolante

close all;
clear
clc

%caricamento del data set
A=load('dataset1.dat');

%estrazione dei dati x e y
n=size(A,1); % numero di dati (punti sul piano)
x=A(1:n,1)'; % vettore riga delle ascisse trasposto
y=A(1:n,2)'; % vettore riga delle ordinate trasposto

%definire il grado del polinomio interpolante
g=n-1;

%definire gli estremi dell'intervallo di interpolazione
a=min(x);
b=max(x);

%calcolo del polinomio interpolante nella forma di Lagrange
%i coefficienti del polinmio sono i dati y(i)

%punti su cui valutare l'interpolante polinomiale per il grafico
xv=linspace(a,b,100);

%valutazione polinomio interpolante mediante II forma baricentrica
%(vedi function lagrval2.m)
yv=lagrval2(y,x,xv);

%grafico dati (x,y) e valori polinomio interpolante (xv,yv)
figure(1)
plot(x,y,'ko','LineWidth',2);
hold on;
plot(xv,yv,'r-','LineWidth',2);
