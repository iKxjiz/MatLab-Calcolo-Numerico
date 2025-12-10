%script slung_ppbez.m
%calcolo della lunghezza di una curva 2D di Bezier

clear
close all

open_figure(1);
axis_plot(1,0.05);

% carico la struttura della curva di bezier da file esse.db
cbez = curv2_ppbezier_load("ppbez_esse.db");

%disegno della curva e suoi punti di controllo
curv2_ppbezier_plot(cbez,40,'b',2);
point_plot(cbez.cp,'k-o',2);

%calcolo lunghezza della curva e sua stampa
val = curv2_ppbezier_len(cbez);
fprintf('Lunghezza della curva: %e\n',val);