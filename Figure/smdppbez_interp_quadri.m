% =========================================================================
% SCRIPT: Disegno geometrico con curve di Bézier - Pattern circolare
% =========================================================================
% OBIETTIVO:
% Creare un disegno con tre livelli concentrici di "petali" colorati:
% - Livello esterno: 12 petali rossi
% - Livello intermedio: 5 petali verdi
% - Livello interno: 4 petali blu
%
% COSTRUZIONE:
% 1. Creare metà sinistra del petalo base con due curve di Bézier quadratiche
% 2. Riflettere per simmetria per ottenere il petalo completo
% 3. Traslare, scalare e ruotare per creare i tre livelli
% =========================================================================

close all;
clear;
clc;

% PARAMETRI

np = 50;         % Numero di punti per plotting/valutazione
tol = 1.0e-6;    % Tolleranza per unione curve

% STEP 1: COSTRUZIONE PETALO BASE - PARTE SINISTRA

open_figure(1);
title('Costruzione petalo base');

% Parte sinistra bassa (curva di Bézier quadratica)
pp_sx_l.deg = 2;
pp_sx_l.ab = [0, 1];
pp_sx_l.cp = [
    0.0,  0.0;
    -0.06, 0.2;
    -0.2,  0.2
    ];

% Parte sinistra alta (curva di Bézier quadratica)
pp_sx_h.deg = 2;
pp_sx_h.ab = [0, 1];
pp_sx_h.cp = [
    -0.2,  0.2;
    -0.06, 0.2;
    0.0,  0.4
    ];

% NOTA: Le coordinate sono state scelte per creare una forma "a goccia"
% simmetrica. I punti di controllo determinano la curvatura.

% Unisci le due parti per formare la metà sinistra del petalo
pp_sx = curv2_mdppbezier_join(pp_sx_l, pp_sx_h, tol);

% STEP 2: RIFLESSIONE PER SIMMETRIA - PARTE DESTRA

% Crea la matrice di simmetria rispetto all'asse verticale passante
% per il primo e ultimo punto della curva sinistra
Sy = get_mat2_symm(pp_sx.cp(1, :), pp_sx.cp(end, :));

% Rifletti la parte sinistra per ottenere la parte destra
pp_dx = pp_sx;
pp_dx.cp = point_trans(pp_dx.cp, Sy);

% Unisci sinistra e destra per formare il petalo completo
quad = curv2_mdppbezier_join(pp_sx, pp_dx, tol);
quad = curv2_mdppbezier_close(quad);  % Chiudi la curva

% STEP 3: LIVELLO ESTERNO - 12 PETALI ROSSI

% Trasformazioni per posizionare i petali esterni
T1 = get_mat_trasl([0, -0.2]);   % Centra il petalo nell'origine
S = get_mat_scale([1.3, 1.3]);   % Scala del 30%
T2 = get_mat_trasl([0.95, 0]);   % Sposta a destra (raggio cerchio)
M_ext = T2 * S * T1;             % Composizione trasformazioni

% Applica le trasformazioni al petalo base
ext_quad = quad;
ext_quad.cp = point_trans(ext_quad.cp, M_ext);

% Disegna il primo petalo
punti = curv2_mdppbezier_plot(ext_quad, -np);
point_fill(punti, 'r', 'b', 2);

% Ruota di 30° (360°/12) per creare gli altri 11 petali
nr_ext = 12;
alpha_ext = (2*pi) / nr_ext;
R_ext = get_mat2_rot(alpha_ext);

for i = 1:(nr_ext - 1)
    ext_quad.cp = point_trans(ext_quad.cp, R_ext);
    punti = curv2_mdppbezier_plot(ext_quad, -np);
    point_fill(punti, 'r', 'b', 2);
end

% STEP 4: LIVELLO INTERMEDIO - 5 PETALI VERDI

% Trasformazioni per il livello intermedio
T1_int = get_mat_trasl([0, -0.2]);  % Centra il petalo
S_int = get_mat_scale([2.2, 2.2]);  % Scala maggiore
T2_int = get_mat_trasl([0, 0.6]);   % Sposta verso l'alto
M_int = T2_int * S_int * T1_int;    % Composizione

% Applica le trasformazioni
inter_quad = quad;
inter_quad.cp = point_trans(inter_quad.cp, M_int);

% Ruota di 72° (360°/5) per creare 5 petali
nr_int = 5;
alpha_int = (2*pi) / nr_int;
R_int = get_mat2_rot(alpha_int);

for i = 1:nr_int
    inter_quad.cp = point_trans(inter_quad.cp, R_int);
    punti = curv2_mdppbezier_plot(inter_quad, -np);
    point_fill(punti, 'g', 'b', 2);
end

% STEP 5: LIVELLO INTERNO - 4 PETALI BLU

% Trasformazioni per il livello interno
T1_inn = get_mat_trasl([0, -0.2]);  % Centra il petalo
S_inn = get_mat_scale([1.6, 1.6]);  % Scala intermedia
T2_inn = get_mat_trasl([0, 0.32]);  % Sposta verso l'alto (meno del livello intermedio)
M_inn = T2_inn * S_inn * T1_inn;    % Composizione

% Applica le trasformazioni
inner_quad = quad;
inner_quad.cp = point_trans(inner_quad.cp, M_inn);

% Ruota di 90° (360°/4) per creare 4 petali
nr_inn = 4;
alpha_inn = (2*pi) / nr_inn;
R_inn = get_mat2_rot(alpha_inn);

for i = 1:nr_inn
    inner_quad.cp = point_trans(inner_quad.cp, R_inn);
    punti = curv2_mdppbezier_plot(inner_quad, -np);
    point_fill(punti, 'b', 'b', 2);
end

% NOTE FINALI
%
% STRUTTURA DEL DISEGNO:
% Il disegno è composto da tre livelli concentrici:
% 1. Esterno: 12 petali rossi (raggio ~0.95, scala 1.3)
% 2. Intermedio: 5 petali verdi (raggio ~0.6, scala 2.2)
% 3. Interno: 4 petali blu (raggio ~0.32, scala 1.6)
%
% TRASFORMAZIONI GEOMETRICHE UTILIZZATE:
% - Traslazione (T): sposta i punti nel piano
% - Scala (S): ingrandisce/rimpicciolisce mantenendo le proporzioni
% - Rotazione (R): ruota attorno all'origine
% - Simmetria (Sy): riflette rispetto a un asse
%
% COMPOSIZIONE TRASFORMAZIONI:
% Le trasformazioni si compongono moltiplicando le matrici.
% L'ordine è importante: M = T2 * S * T1 significa:
%   1. Applica T1 (centra)
%   2. Applica S (scala)
%   3. Applica T2 (sposta alla posizione finale)
%
% CURVE DI BÉZIER:
% - Grado 2 (quadratiche): 3 punti di controllo
% - Il primo e ultimo punto sono sulla curva
% - Il punto centrale controlla la curvatura