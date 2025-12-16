%script spoly_eval.m
% Errore algoritmico nella valutazione polinomiale
% viene prodotto il grafico della funzione polinomiale
% nell'intervallo di definizione
clc
clear
close all

% La "d" davanti alle variabili indica che sono in doppia precisione

% dc è il vettore dei coefficienti (oridnato da quello di potenza
% massima a quella minima)
dc=[1, -39, 504, -2158];
% altre possibili scelte di dc per test :
% dc=[100, -3900, 50410, -215800];
% dc=[10, -390, 5041, -21580];

% Estremi intervallo di definizione :
% da (estremo a in doppia precisione),db (estremo b in doppia precisione)
da=10; db=16;

sa=single(da); % conversione in singola precisione dell'estremo a
sb=single(db); % conversione in singola precisione dell'estremo b
sc=single(dc); % conversione in singola precisione del vettore dei coefficienti
n=length(dc); % grado del polinomio + 1

% %punti equispaziati (commentare/scommentare)
% nn=101;
% dx=linspace(da,db,nn);

%(commentare/scommentare)
% h=0.000244140625;
% dx=da:h:db;

%(commentare/scommentare)
% h=2^-4;
% dx=da:h:db;

%(commentare/scommentare)
h=2^-5; % step di campionamento
dx=da:h:db; % vettore dei punti equispaziati da valutare

%(commentare/scommentare)
% h=2^-7;
% dx=da:h:db;

m=length(dx); % numero dei punti di valutazione
sx=single(dx); % conversione in singola precisione del vettore dei punti

% % richiama direttamente la built-function polyval
% dy=polyval(dc,dx);
% sy=polyval(sc,sx);

% richiama la function poly_eval - valutazione polinomiale (Ruffini-Horner)
dy=poly_eval(dc,dx,2,1); % valutazione in doppia precisione
sy=poly_eval(sc,sx,2,0); % valutazione in singola precisione

%grafico del polinomio
figure('Position', [10 10 500 600])
subplot(2,1,1);
hold on;
plot(dx,dy,'r.-','LineWidth',1.5);
plot(dx,zeros(1,m),'k-','LineWidth',1.5);
title('Polinomio test','FontWeight','bold')

%grafico dell'errore relativo
subplot(2,1,2);
relerr=abs((sy-dy)./dy);
plot(dx,relerr,'b.-');

% %stampa degli errori relativi
% out(1,:)=dx;
% out(2,:)=dy;
% out(3,:)=relerr;
% fprintf('\n');
% fprintf('Stampa degli Errori Relativi per ogni punto \n',out);
% fprintf('x                      y                     Err\n');
% fprintf('%20.15e %20.15e %20.15e \n',out);