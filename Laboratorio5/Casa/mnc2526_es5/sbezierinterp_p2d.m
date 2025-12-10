%% script sbezierinterp_p2d.m
% interpolazione di un "set di punti 2D" con curve di Bezier
clear
close all

col=['r','g','b','k'];
open_figure(1);
title('Interpolazione di set di punti 2D con curve di Bezier');
axis_plot(3,0.25);
grid on;

%% alcuni set di punti da interpolare (commentare/scommentare)

% Q : lista dei punti 2D di interpolazione (g+1)x2

Q1=[0,2; 1,1; 2,1; 3,2];
Q2=[0,2; 2,1; 1,1; 3,2];
Q3=[0,0; 1,1; 2,2; 3,3];
Q4=[0,2; 1,2; 2,2; 3,1];
Q5=[5.0000   10.0000
    1.8       8.7
    1.8       6.2
    3.2       3.8
    3.2       1.3
    0.0       0.0];

%disegno punti da interpolare
point_plot(Q1,'ko:',1.5,'k');


%% Inizializzazione del disegno :  NOTA : CASO SET DI PUNTI 2D

% estremi dell'intervallo di interpolazione
a = 0;
b = 1;

% scelta della paremetrizzazione : 0=uniforme, 1=centripeta, 2=corda
param = 0;

% Interpolare vuol dire costruire una curva di Bezier che passi per i punti dati Q,
% quindi trovare i punti di controllo della curva di Bezier che interpola Q.
% cbez = interpolazione di Q con curve di Bezier su [a b] con la parametrizzazione scelta
cbezQ1_0 = curv2_bezier_interp(Q1, a, b, 0);
cbezQ1_1 = curv2_bezier_interp(Q1, a, b, 1);
cbezQ1_2 = curv2_bezier_interp(Q1, a, b, 2);
% cbez <-- struttura della curva 2D di Bezier :
%           bezier.deg --> grado della curva
%           bezier.cp  --> lista dei punti di controllo
%           bezier.ab  --> intervallo di definizione [a b]

%% NOTA : vedere la funzione curv2_bezier_interp.m per i dettagli / funzionamento sull'interpolazione

%% Disegno della curva di Bezier interpolante
np = 100; % numero di punti per il disegno della curva
% np punti equispaziati in [a b], più sono, più la curva risulta liscia

% curv2_ppbezier_plot disegna una curva 2D spline di Bezier con np punti di valutazione
curv2_ppbezier_plot(cbezQ1_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ1_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ1_2,np, 'g-', 2);

%% Altri set di punti da interpolare
%% Q2 :


open_figure(2);
axis_plot(3,0.25);
title('Interpolazione di set di punti 2D con curve di Bezier');
grid on;
point_plot(Q2,'ko:',1.5,'k');

cbezQ2_0 = curv2_bezier_interp(Q2, a, b, 0);
cbezQ2_1 = curv2_bezier_interp(Q2, a, b, 1);
cbezQ2_2 = curv2_bezier_interp(Q2, a, b, 2);

curv2_ppbezier_plot(cbezQ2_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ2_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ2_2,np, 'g-', 2);

%% Q3 :


open_figure(3);
axis_plot(3,0.25);
title('Interpolazione di set di punti 2D con curve di Bezier');
grid on;
point_plot(Q3,'ko:',1.5,'k');

cbezQ3_0 = curv2_bezier_interp(Q3, a, b, 0);
cbezQ3_1 = curv2_bezier_interp(Q3, a, b, 1);
cbezQ3_2 = curv2_bezier_interp(Q3, a, b, 2);

curv2_ppbezier_plot(cbezQ3_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ3_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ3_2,np, 'g-', 2);

%% Q4 :


open_figure(4);
axis_plot(3,0.25);
title('Interpolazione di set di punti 2D con curve di Bezier');
grid on;
point_plot(Q4,'ko:',1.5,'k');

cbezQ4_0 = curv2_bezier_interp(Q4, a, b, 0);
cbezQ4_1 = curv2_bezier_interp(Q4, a, b, 1);
cbezQ4_2 = curv2_bezier_interp(Q4, a, b, 2);

curv2_ppbezier_plot(cbezQ4_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ4_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ4_2,np, 'g-', 2);

%% Q5 :


open_figure(5);
axis_plot(12,0.5);
title('Interpolazione di set di punti 2D con curve di Bezier');
grid on;
point_plot(Q5,'ko:',1.5,'k');

cbezQ5_0 = curv2_bezier_interp(Q5, a, b, 0);
cbezQ5_1 = curv2_bezier_interp(Q5, a, b, 1);
cbezQ5_2 = curv2_bezier_interp(Q5, a, b, 2);

curv2_ppbezier_plot(cbezQ5_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ5_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ5_2,np, 'g-', 2);

%% Test : prendiamo un set brutto

Q=[0,2; 1.4,1; 1.7, 1; 2,1; 3,2];

open_figure(6);
axis_plot(3,0.25);
title('Interpolazione di set di punti 2D con curve di Bezier');
grid on;

point_plot(Q,'ko:',1.5,'k');

cbezQ_0 = curv2_bezier_interp(Q, a, b, 0);
cbezQ_1 = curv2_bezier_interp(Q, a, b, 1);
cbezQ_2 = curv2_bezier_interp(Q, a, b, 2);

curv2_ppbezier_plot(cbezQ_0,np, 'r-', 2);
curv2_ppbezier_plot(cbezQ_1,np, 'b-', 2);
curv2_ppbezier_plot(cbezQ_2,np, 'g-', 2);

% si può vedere come anche con set di punti "difficili" l'interpolazione con curve di Bezier
% a patto di scegliere una buona parametrizzazione (centripeta o a corda)
% riesce a dare buoni risultati senza oscillazioni indesiderate.
% Invece la parametrizzazione uniforme può portare a risultati scadenti.
% Questo è dovuto al fatto che la parametrizzazione uniforme non tiene conto della distribuzione
% dei punti nello spazio, mentre le altre due lo fanno in modo più efficace.






