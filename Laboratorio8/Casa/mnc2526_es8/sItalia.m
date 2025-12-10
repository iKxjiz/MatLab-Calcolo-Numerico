%==========================================================================
% Script: smbppbez_interp_italy.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 1 a destra, utilizzando
% curve di Bézier a tratti multi-grado, ottenute come join di curve
% di Bezier di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. (Cerchio con la bandiera dell'italia)
%==========================================================================

clear all
clc

%% ===== INIZIALIZZAZIONE E SETUP FIGURA =====

open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

% Parametri generali
n = 20;          % Numero di punti per interpolazione
mp = 100;        % Numero di punti per il plotting
tol = 1.0e-2;    % Tolleranza per il join delle curve
param = 0;       % Parametro di interpolazione

%% ===== CREAZIONE CIRCONFERENZE ESTERNE E INTERNE =====
% NOTE SEZIONE: Costruzione del bordo circolare esterno e interno
% mediante interpolazione di Hermite con curva cubica a tratti

% Punti di Chebyshev per una distribuzione ottimale
t = chebyshev2(0, 2*pi, n + 1);
% NOTA : in esame, va fatta mano la funzione chebyshev2 non importando la
% funzione da altre cartelle nelle directory di lavoro !!!!
[x, y, xp, yp] = cp2_circle(t);

% Circonferenza esterna
ppP = curv2_bezier_interp([x', y'], 0, 2*pi, 2);
curv2_ppbezier_plot(ppP, mp, 'b', 2);

% Circonferenza interna (scalata al 97%)
S = get_mat_scale([0.97, 0.97]);
ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, S);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 2);

%% ===== CREAZIONE E TRASFORMAZIONE DELLE RETTE DIVISORIE =====
% NOTE SEZIONE: Costruzione delle rette orizzontali che dividono la bandiera
% e loro trasformazione in verticali mediante rotazione

% Definizione rette orizzontali iniziali
r1 = [-1 0.3; 1 0.3];   % Retta superiore
r2 = [-1 -0.3; 1 -0.3]; % Retta inferiore

ppr1 = curv2_bezier_interp(r1, 0, 1, param);
ppr2 = curv2_bezier_interp(r2, 0, 1, param);

% Matrici di trasformazione per ruotare le rette
C = [0, 0.3];
T1r1 = get_mat_trasl(-C);
T1r2 = get_mat_trasl(C);
T2r1 = get_mat_trasl([0.32, 0]);
T2r2 = get_mat_trasl([-0.32, 0]);
R = get_mat2_rot(pi/2);

% Composizione trasformazioni e applicazione
M1 = T2r1 * R * T1r1;
M2 = T2r2 * R * T1r2;

ppr1.cp = point_trans(ppr1.cp, M1);
ppr2.cp = point_trans(ppr2.cp, M2);

% Visualizzazione rette trasformate
curv2_ppbezier_plot(ppr1, mp, 'r', 2);
curv2_ppbezier_plot(ppr2, mp, 'r', 2);
point_plot(ppr1.cp(1,:), 'ko', 3);
point_plot(ppr2.cp(1,:), 'ko', 3);

%% ===== CALCOLO INTERSEZIONI =====
% NOTE SEZIONE: Determinazione dei punti di intersezione tra le rette
% divisorie e la circonferenza interna

[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppr1, ppP_intern);
[IP1P2_r2, t1_r2, t2_r2] = curv2_intersect(ppr2, ppP_intern);

if length(t1_r1) > 0
    % Visualizzazione punti di intersezione
    point_plot(IP1P2_r1', 'go', 1, 'g', 'g', 8);
    point_plot(IP1P2_r2', 'go', 1, 'g', 'g', 8);

    % Stampa informazioni
    fprintf('\n=== PUNTI DI INTERSEZIONE SEGMENTO DX ===\n');
    fprintf('IP1P2_dx = %e %e\n', IP1P2_r1);
    fprintf('t1 = %e\n', t1_r1);
    fprintf('t2 = %e\n', t2_r1);

    fprintf('\n=== PUNTI DI INTERSEZIONE SEGMENTO SX ===\n');
    fprintf('IP1P2_sx = %e %e\n', IP1P2_r2);
    fprintf('t1 = %e\n', t1_r2);
    fprintf('t2 = %e\n', t2_r2);
else
    error('Nessuna intersezione trovata!');
end

%% ===== COSTRUZIONE E COLORAZIONE REGIONE ROSSA (DESTRA) =====
% NOTE SEZIONE: Suddivisione della circonferenza interna e creazione
% della regione destra (rossa) della bandiera

open_figure(2);
hold on;
curv2_ppbezier_plot(ppP, mp, 'k', 3);

% Suddivisione della circonferenza nei punti di intersezione
[p1_sx, p1_dx] = decast_subdiv(ppP_intern, t2_r1(1));
[p1_1_sx, p1_1_dx] = decast_subdiv(ppP_intern, t2_r1(2));

% Join delle curve e chiusura della regione
union_dx = curv2_mdppbezier_join(p1_dx, p1_1_sx, tol);
union_dx = curv2_mdppbezier_close(union_dx);

% Plot e riempimento con colore rosso
union_dx_points = curv2_mdppbezier_plot(union_dx, -mp, 'k', 3);
point_fill(union_dx_points, [1, 0, 0]);

%% ===== COSTRUZIONE E COLORAZIONE REGIONE VERDE (SINISTRA) =====
% NOTE SEZIONE: Rotazione della circonferenza e creazione della regione
% sinistra (verde) della bandiera

% Rotazione di 180° per lavorare sulla parte opposta
R = get_mat2_rot(pi);
ppP_intern.cp = point_trans(ppP_intern.cp, R);

% Suddivisione e join analogamente alla regione destra
[p2_sx, p2_dx] = decast_subdiv(ppP_intern, t2_r1(1));
[p2_2_sx, p2_2_dx] = decast_subdiv(ppP_intern, t2_r1(2));

union_sx = curv2_mdppbezier_join(p2_dx, p2_2_sx, tol);
union_sx = curv2_mdppbezier_close(union_sx);

% Plot e riempimento con colore verde
union_sx_points = curv2_mdppbezier_plot(union_sx, -mp, 'k', 3);
point_fill(union_sx_points, [0.2, 0.7, 0.2]);

%% Funzioni Locali :

function x=chebyshev2( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1
%punti di Chebishev seconda specie
for i=0:n
    x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
end
end