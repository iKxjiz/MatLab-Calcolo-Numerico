%==========================================================================
% Script: smdppbez_interp_scudo.m
%==========================================================================
% DESCRIZIONE:
% Esercizio d'esame di MNC2324
% Riprodurre un disegno composto da:
% - Curva sinusoidale: interpolazione di x(t)=t, y(t)=sin(t) con t∈[0,10π]
% - Scudo centrale: interpolazione con curve di Bézier a tratti
% - Circonferenza: interpolazione con curva di Bézier a tratti
% - Fasce colorate: intersezioni tra sinusoide e circonferenza
%==========================================================================

close all;
clear;
clc

%% Parametri iniziali
np = 30; % Numero punti di valutazione
a = 0; % Inizio intervallo sinusoide
b = 10*pi; % Fine intervallo sinusoide
param = 0;
tol = 1.0e-2; % Tolleranza per join curve

%% Creazione e trasformazione curva sinusoidale
open_figure(1);
grid on;

% Interpolazione sinusoide
t = linspace(a, b, np);
[x, y] = sinusoide(t);
Qxy = [x', y'];
ppP = curv2_ppbezierCC1_interp(Qxy, a, b, param);

% Verifica errore interpolazione
Pxy = ppbezier_val(ppP, t);
maxErr = max(vecnorm((Qxy - Pxy)'));
fprintf('ErrMax sinusoide: %d\n', maxErr);

% Trasformazione sinusoide (scala e posizionamento)
T = get_mat_trasl(-ppP.cp(1, :));
S = get_mat_scale([0.016, 0.016]);
T1 = get_mat_trasl([0.25, 0.50]);
M = T1 * S * T;
ppP.cp = point_trans(ppP.cp, M);
curv2_ppbezier_plot(ppP, np, 'b', 3);

%% Creazione e trasformazione circonferenza
t = linspace(pi/2, 5*pi/2, 8);
[xc, yc, xc1, yc1] = cerchio(t);
C = [xc', yc'];
C1 = [xc1', yc1'];
ppC = curv2_ppbezierCC1_interp_der(C, C1, t);

% Trasformazione circonferenza (scala e posizionamento)
T = get_mat_trasl([0, 1]);
T1 = get_mat_trasl([0.5, 0.28]);
S = get_mat_scale([0.22, 0.22]);
M = T1 * S * T;
ppC.cp = point_trans(ppC.cp, M);
curv2_ppbezier_plot(ppC, np, 'r', 3);

%% Costruzione scudo centrale
% Parte curva sinistra
cs.deg = 2;
cs.ab = [0 1];
cs.cp = [0.5, 0.1; 0.1, 0.3; 0.175, 0.8];

% Segmento orizzontale superiore sinistro
ss.deg = 1;
ss.ab = [0, 1];
ss.cp = [0.175, 0.8; 0.5, 0.8];

% Unione parte sinistra
scudo_sx = curv2_mdppbezier_join(cs, ss, tol);

% Riflessione per parte destra
SY = get_mat2_symm([0.5 0], [0.5 0.8]);
scudo_dx = scudo_sx;
scudo_dx.cp = point_trans(scudo_dx.cp, SY);

% Unione completa scudo
scudo = curv2_mdppbezier_join(scudo_sx, scudo_dx, tol);
curv2_mdppbezier_plot(scudo, np, 'r', 3);

%% Figura finale con colorazione
open_figure(2);

% Colorazione scudo
col = [128, 128, 255]/255;
Sx = curv2_mdppbezier_plot(scudo, -np, 'r', 3);
point_fill(Sx, col, 'k', 2);

% Sfondo
col = [255, 230, 230]/255;
set(gca, 'Color', col);

%% Creazione fasce colorate
np = 40;

% Traslazione iniziale sinusoide
T = get_mat_trasl([0, -0.16]);
ppP.cp = point_trans(ppP.cp, T);

% Prima fascia (gialla)
[I, t1, t2] = curv2_intersect(ppC, ppP);

% Taglio sinusoide
[~, sf] = ppbezier_subdiv(ppP, t2(1));
[sf, ~] = ppbezier_subdiv(sf, t2(2));

% Taglio circonferenza
[~, cc] = ppbezier_subdiv(ppC, t1(1));
[cc, ~] = ppbezier_subdiv(cc, t1(2));

% Unione e colorazione prima fascia
fascia = curv2_mdppbezier_join(sf, cc, tol);
Px = curv2_mdppbezier_plot(fascia, -np, 'c', 3);
point_fill(Px, 'y');

%% Ciclo per fasce successive
fasciaSuperiore = ppP;
T = get_mat_trasl([0, 0.08]);

for i = 1:4
    % Preparazione fasce
    fasciaInferiore = fasciaSuperiore;
    fasciaSuperiore.cp = point_trans(fasciaSuperiore.cp, T);

    % Calcolo intersezioni
    [I1, t1, t2] = curv2_intersect(fasciaInferiore, ppC);
    [I2, t3, t4] = curv2_intersect(fasciaSuperiore, ppC);

    % Taglio sinusoide inferiore
    [~, sf] = ppbezier_subdiv(fasciaInferiore, t1(1));
    [sfi, ~] = ppbezier_subdiv(sf, t1(2));

    % Taglio sinusoide superiore
    [~, sf] = ppbezier_subdiv(fasciaSuperiore, t3(1));
    [sfs, ~] = ppbezier_subdiv(sf, t3(2));

    % Taglio circonferenza sinistra
    [~, cc] = ppbezier_subdiv(ppC, t4(1));
    [ccs, ~] = ppbezier_subdiv(cc, t2(1));

    % Taglio circonferenza destra
    [~, cc] = ppbezier_subdiv(ppC, t2(2));
    [ccd, ~] = ppbezier_subdiv(cc, t4(2));

    % Unione parti per fascia completa
    mezzaSinistra = curv2_mdppbezier_join(sfi, ccs, tol);
    mezzaDestra = curv2_mdppbezier_join(sfs, ccd, tol);
    fascia = curv2_mdppbezier_join(mezzaSinistra, mezzaDestra, tol);

    % Colorazione alternata (giallo/nero)
    Px = curv2_mdppbezier_plot(fascia, -np, 'c', 3);
    if (mod(i, 2) == 0)
        point_fill(Px, 'y');
    else
        point_fill(Px, 'k');
    end
end

%% Ultima fascia
% Taglio circonferenza per ultima fascia
[ccs, ~] = ppbezier_subdiv(ppC, t4(1));
[~, ccd] = ppbezier_subdiv(cc, t4(2));

% Unione e colorazione ultima fascia
fascia = curv2_mdppbezier_join(ccs, ccd, tol);
fascia = curv2_mdppbezier_join(fascia, sfs, tol);
Px = curv2_mdppbezier_plot(fascia, -np, 'c', 3);
point_fill(Px, 'k');

%% Funzioni locali

function [x, y] = sinusoide(t)
% Curva sinusoidale parametrica
x = t;
y = sin(t);
end

function [x, y, xd, yd] = cerchio(t)
% Circonferenza parametrica con derivate
x = cos(t);
y = sin(t);
xd = -sin(t);
yd = cos(t);
end