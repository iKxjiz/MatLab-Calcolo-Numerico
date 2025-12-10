%script smdppbezmodel_calice_interp_svg.m
%join di curve per fare un disegno
clear
close all;
open_figure(1);
grid on;

a = 0;
b = 1;
param = 0;

%% curva di Bézier di grado 2 di interpolazione dei seguenti punti
P1= [3.0 1.0; 4.5 1.5; 5.0 2.0];
primo_tratto = curv2_bezier_interp(P1, a, b, param);

% curv2_bezier_interp : funzione che calcola i punti di controllo di una curva di Bézier
% di grado n che interpola n+1 punti dati.
% P1 : matrice (n+1)x2 dei punti da interpolare
% a, b : estremi dell'intervallo del parametro t
% param : parametro di forma (0 per curva di Bézaddpath(fullfile(scriptPath,'..', '..', '..', 'anmglib_5.0', 'ppbez_code'));ier standard)

%% una curva di Bézier di grado 3 di interpolazione dei seguenti punti
P2 = [5.0 4.0; 3.4 4.4; 2.9 5.6; 4.0 8.0];
secondo_tratto = curv2_bezier_interp(P2, a, b, param);

% curv2_bezier_interp : funzione che calcola i punti di controllo di una curva di Bézier
% di grado n che interpola n+1 punti dati.
% P2 : matrice (n+1)x2 dei punti da interpolare
% a, b : estremi dell'intervallo del parametro t
% param : parametro di forma (0 per curva di Bézier standard)

% scelgo a = 0 e b = 1 come estremi dell'intervallo del parametro t perche' sono
% i valori di default per le curve di Bézier e quindi. E poi perche' cosi' e' piu' semplice fare i calcoli
% per trovare i punti di giunzione tra le curve.

%% Disegna le due curve
curv2_bezier_plot(primo_tratto, 100, 'b', 2);
curv2_bezier_plot(secondo_tratto, 100, 'b', 2);

%% Unisci le due curve con una curva a tratti multi-grado e disegnala
tol=0.5e-2;
terzo_tratto.deg = 1;
terzo_tratto.ab = [0 1];
terzo_tratto.cp = [5.0 2.0; 5.0 4.0]; % punti di giunzione

%curv2_bezier_plot(terzo_tratto, 100, 'b', 2);

unione_tratto_uno = curv2_mdppbezier_join(primo_tratto, terzo_tratto, tol);
unione_tratto_due = curv2_mdppbezier_join(unione_tratto_uno, secondo_tratto, tol);

%prendo i punti della curva unita
%CurvaSx = curv2_mdppbezier_plot(unione_tratto_due, 200, 'b', 2);

%% genera la curva simmetrica e disegnala
SY = get_mat2_symm([6.0 1.0], [6.0 8.0]);

riflessa = unione_tratto_due;
riflessa.cp = point_trans(unione_tratto_due.cp, SY);

%CurvaDx = curv2_mdppbezier_plot(riflessa, 200, 'b', 2);

%% Unisci le due curve, chiudi la curva finale e disgnala colorata

% crea i tratti superiore e inferiore per chiudere la curva
tratto_sopra.deg = 1;
tratto_sopra.ab = [0 1];
tratto_sopra.cp = [4.0 8.0; 8.0 8.0];

tratto_sotto.deg = 1;
tratto_sotto.ab = [0 1];
tratto_sotto.cp = [3.0 1.0; 9.0 1.0];

unione_sinistra_sotto = curv2_mdppbezier_join(unione_tratto_due, tratto_sotto, tol);
unione_sotto_destra = curv2_mdppbezier_join(unione_sinistra_sotto, riflessa, tol);
unione_completa = curv2_mdppbezier_join(unione_sotto_destra, tratto_sopra, tol);

punti_unione_completa = curv2_mdppbezier_plot(unione_completa, 150, 'b', 4);
point_fill(punti_unione_completa, 'r');

%% Salva la curva come file SVG e ricaricala

svg_struct=svg_struct_add(unione_completa,'b',0.025,'r');
svg_plot(svg_struct);

svg_struct.transform="rotate(180, 5.5, 4.5)";
svg_save(svg_struct,'calice.svg');
%svg_struct=svg_load('calice.svg')
%svg_plot(svg_struct);
%svg_struct.transform
