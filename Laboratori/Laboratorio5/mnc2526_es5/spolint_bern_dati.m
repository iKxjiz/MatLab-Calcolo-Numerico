% script spolint_bern_dati.m
% Interpolazione polinomiale di un set di dati nella forma di Bernstein;
% viene prodotto il grafico del data set e del polinomio interpolante

close all
clear
clc

% caricamento del data set
A=load('dataset1.dat');

% estrazione dei dati x e y
n=size(A,1); % numero di dati (punti sul piano)
x=A(1:n,1)'; % vettore riga delle ascisse trasposto
y=A(1:n,2)'; % vettore riga delle ordinate trasposto

%definire il grado del polinomio interpolante
g=n-1;

%definire gli estremi dell'intervallo di interpolazione
a=min(x);
b=max(x);

%Metodo di interpolazione: forma di Bernstein
%cambio di variabile
t=(x-a)./(b-a);

% e calcolo della matrice B del sistema lineare per i coefficienti del polinomio
B=bernst_val(g,t);

%i coefficienti del polinomio sono la soluzione del sistema lineare
%utilizziamo l'operatore left division di Matlab
c=B\y';

%definiamo un polinomio nella base di Bernstein secondo la anmglib_5.0
bern.deg=g;
bern.cp=c;
bern.ab=[a,b];

%punti su cui valutare l'interpolante polinomiale per il grafico
xv=linspace(a,b,100);

%valutazione polinomio interpolante mediante de Casteljau
%(vedi function decast_val.m)
yv=decast_val(bern,xv);

%grafico dati (x,y) e valori polinomio interpolante (xv,yv)
figure(1)
plot(x,y,'ko','LineWidth',1.5);
hold on;
plot(xv,yv,'r-','LineWidth',2);
