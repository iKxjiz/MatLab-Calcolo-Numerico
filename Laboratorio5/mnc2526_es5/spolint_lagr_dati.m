% script spolint_lagr_dati.m
% Interpolazione polinomiale di un set di dati nella forma di Lagrange;
% viene prodotto il grafico del data set e del polinomio interpolante
clear
close all

%A=load('dataset1.dat');
A=load('dataset2.dat');
%A=load('dataset3.dat'); % ===> Si vede l'inflessibilità della funzione

[n m]=size(A);
x=A(1:n,1)';
y=A(1:n,2)';

%definire il grado del polinomio interpolante
g=n-1;

% più è alto il grado del polinomio interpolante
% più ha libertà di oscillare la funzione (se non sono ben calibrati)

%definire gli estremi dell'intervallo di interpolazione
a=min(x);
b=max(x);

%calcolo del polinomio interpolante nella forma di Lagrange
%i coefficienti del polinmio sono i dati y(i)

%punti su cui valutare l'interpolante polinomiale per il grafico
xv=linspace(a,b,100); % Seconda forma baricentrica (Algoritmo implementato)

%valutazione polinomio interpolante mediante II forma baricentrica
%(vedi function lagrval2.m)
yv=lagrval2(y,x,xv);

%grafico dati (x,y) e valori polinomio interpolante (xv,yv)
figure(1)
plot(x,y,'ko','LineWidth',2);
hold on;
plot(xv,yv,'r-','LineWidth',2);


% Leggere dati
% Definire il grado del polinomio
% Valutazione del polinomio interpolante