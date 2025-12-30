% Esercizio d'esame di MNC2324 di Casula
% Fare uno script per riprodurre il seguente disegno.
% Riprodurre la curva rossa a forma di esse per interpolazione con una
% curva di Bézier; si determini la curva blu per simmetria della rossa
% rispetto alla retta verticale x=5, poi la si ruoti di pi/2 rispetto
% al punto [5,-5].

close all;
clear all;
clc

%% ===================== FIGURA 1: Curve rossa e blu =====================
open_figure(1);
grid on;
axis_plot(5, 0.125);

np = 200;
tol = 1.0e-2;
param = 0;

% Punti di interpolazione per la curva a forma di "S"
Q = [
    0,    0;
    2.04, 0.21;
    3.35, 1.3;
    1.75, 3.38;
    1.89, 4.29;
    2.95, 4.78;
    5,    5
    ];

a = min(Q(:, 1));
b = max(Q(:, 1));

% Interpolazione della curva rossa
rossa = curv2_ppbezierCC1_interp(Q, a, b, param);
curv2_ppbezier_plot(rossa, 30, 'r', 3);

% --- Costruzione curva blu per simmetria rispetto a x=5 ---
% Strategia: trasla di -5, rifletti rispetto a asse y, ritrasla di +5
T = get_mat_trasl([-5, 0]);
Sy = get_mat2_symm([0 0], [0 1]);  % simmetria rispetto asse y
M = Sy * T;

blu = rossa;
blu.cp = point_trans(blu.cp, M);

% Ritraslazione (inverti la traslazione)
T(1:2, 3) = -T(1:2, 3);  % T diventa traslazione di [+5, 0]
blu.cp = point_trans(blu.cp, T);

% --- Rotazione di pi/4 attorno al punto [5, -5] ---
R = get_mat2_rot(pi/4);
T = get_mat_trasl([-5, -5]);
Tinv = get_mat_trasl([-2.07, 2.07]);  % correzione empirica per allineamento
M = Tinv * R * T;
blu.cp = point_trans(blu.cp, M);

curv2_ppbezier_plot(blu, 30, 'b', 3);

%% ===================== FIGURA 2: Braccio (intersezione) =====================
open_figure(2);
grid on;
axis_plot(5, 0.125);

% Trova intersezione tra curva rossa e blu
[~, t1, t2] = curv2_intersect(rossa, blu);

% Suddividi le curve al punto di intersezione
[~, rossa] = ppbezier_subdiv(rossa, t1);
[~, blu] = ppbezier_subdiv(blu, t2);

% Unisci le due porzioni per formare il braccio
braccio = curv2_mdppbezier_join(rossa, blu, tol);
curv2_ppbezier_plot(braccio, 30, 'r', 3);

%% ===================== FIGURA 3: Figura finale (8 bracci) =====================
open_figure(3);

alfa = pi/4;  % rotazione di 45° = 2*pi/8 (per 8 bracci)
R = get_mat2_rot(alfa);

% Trasla il braccio per ruotare attorno a [5, -5]
T = get_mat_trasl([-5, 5]);
braccio.cp = point_trans(braccio.cp, T);

% Costruisci la figura completa con 8 bracci
finale = braccio;
for i = 1:7
    braccio.cp = point_trans(braccio.cp, R);
    finale = curv2_mdppbezier_join(finale, braccio, tol);
end

% Riporta la figura nella posizione originale
Tinv = get_mat_trasl([5, -5]);
finale.cp = point_trans(finale.cp, Tinv);

% Disegna e riempi la figura finale
Px = curv2_ppbezier_plot(finale, -30);
point_fill(Px, 'b');

% --- Cerchio interno ---
t = linspace(0, 2*pi, 8);
[x, y, xd, yd] = cerchio(t);

% Interpolazione del cerchio con derivate
ppC = curv2_ppbezierCC1_interp_der([x', y'], [xd', yd'], t);

% Scala e trasla il cerchio
S = get_mat_scale([5, 5]);
M = Tinv * S;
ppC.cp = point_trans(ppC.cp, M);

% Disegna e riempi il cerchio
Px = curv2_ppbezier_plot(ppC, -30);
point_fill(Px, 'r');

%% ===================== FUNZIONE AUSILIARIA =====================
function [x, y, xd, yd] = cerchio(t)
% Parametrizzazione del cerchio unitario con derivate
x  =  cos(t);
y  =  sin(t);
xd = -sin(t);
yd =  cos(t);
end