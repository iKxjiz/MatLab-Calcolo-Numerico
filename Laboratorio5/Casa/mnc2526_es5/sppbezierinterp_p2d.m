%% script sppbezierinterp_p2d.m
%interpolazione con curva cubica a tratti C1 di Hermite di punti 2D
clear
close all

vcol=['r','g','b','k'];
open_figure(1);
grid on;

%legge la lista di punti da interpolare da file .txt
Q=load('paperino.txt');
% Q=load('twitter.txt');

%disegna i punti da interpolare
point_plot(Q,'ko:',1,'k','k',4);

%1.chiama function curv2_ppbezierCC1_interp di interpolazione
%cubica a tratti C1 di Hermite
%2.disegna curva cubica a tratti C1 di interpolazione

% function ppP=curv2_ppbezierCC1_interp(Q,a,b,param)
% Calcola la struttura Bezier cubica a tratti 2D di Hermite
% di interpolazione di una lista di punti 2D

% intervallo di interpolazione [a,b]
a = 0;
b = 1;

param = 1; % scelta della parametrizzazione : 0 uniforme, 1 centripeta, 2 corda

ppP = curv2_ppbezierCC1_interp(Q, a, b, param);

% disegna la curva spline di Bezier cubica a tratti C1 di Hermite.
% cubica perchè ogni tratto è di grado 3.
% C1 perchè la curva spline risultante è continua e ha derivate prime continue.

%disegna una curva 2D spline di Bezier con np punti di valutazione PER TRATTO
np = 100;
curv2_ppbezier_plot(ppP, np, 'r', 2);
% i nodi ci sono due volte, uno per ogni tratto che li congiunge.
% le derivate sono stimate in modo da garantire la continuità C1.
% la funzione richiederebbe come input le derivate prime in ogni nodo.

% NOTA : vedi anche funzione curv2_ppbezierCC1_interp_der.m
% che calcola la stessa curva spline di Bezier cubica a tratti C1 di Hermite
% ma richiedendo come input le derivate prime in ogni nodo.

%disegna poligonale di controllo
point_plot(ppP.cp,'r-o',2,'k','r',4);

%% Ogni tratto colorato diversamente

open_figure(2);
axis_plot(0.25,0.01);
grid on;

np=100; % numero di punti per il disegno della curva

%estrae e disegna le singole curve di Bézier (i tratti)
nt = length(ppP.ab)-1; % -1 perché ab ha un punto in più che indica la fine dell'ultimo tratto
for i=1:nt
    st = (i-1)*ppP.deg + 1;
    fn = i*ppP.deg + 1;
    col = vcol(mod(i, length(vcol))+1);
    point_plot(ppP.cp(st:fn, :),col,1.5);
    cbez.deg = ppP.deg;
    cbez.cp = ppP.cp(st:fn, :);
    cbez.ab = ppP.ab(i:i+1);
    curv2_ppbezier_plot(cbez,np, col, 2);
end

% "piecewise curve" (curva di Bézier a tratti) :
% ottenuta unendo insieme più curve 2D di Bézier di stesso grado


