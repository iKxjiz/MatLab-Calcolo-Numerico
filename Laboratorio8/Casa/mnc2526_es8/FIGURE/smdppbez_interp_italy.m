%==========================================================================
% Script: smbppbez_interp_italy.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 1 a destra, utilizzando
% curve di B´ezier a tratti multi-grado, ottenute come join di curve
% di Bezier di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. (Cerchio con la bandiera dell'italia)
%==========================================================================
close all;
clear all;
clc

open_figure(1);
axis_plot(1.5, 0.125);
hold on;
grid on;

a = 0;
b = 2*pi;
n = 20;
mp = 100;
tol = 1.0e-2; % Tolleranza buona in molti casi
param=0;

%Determinare la circonferenza per interpolazione di Hermite con una curva
%cubica a tratti ppP
t = linspace(a, b, n);
[x, y, x1, y1] = cp2_circle(t); % SEMBRA ESSERE IL MIGLIORE TRA TUTTI
ppP = curv2_ppbezierCC1_interp_der([x', y'], [x1', y1'], t);
curv2_ppbezier_plot(ppP, mp, 'b', 2);

% Stima dell'errore di interpolazione
npt = 150;
t = linspace(a, b, npt);
Pxy = ppbezier_val(ppP, t);
[x, y] = cp2_circle(t);
Qxy = [x', y'];

MaxErr = max(vecnorm((Pxy-Qxy)'));
fprintf("Massimo errore %e\n", MaxErr);
% Domanda, come lo si gestisce ? cioè se è grande, come lo si diminuisce ?

S = get_mat_scale([0.97, 0.97]);

ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, S);
%ppP_intern = curv2_bezier_reverse(ppP_intern);

curv2_ppbezier_plot(ppP, mp, 'b', 2);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 2);

ppr1.cp = [-1 0.3; 1 0.3];
ppr1.deg = 1;
ppr1.ab = [0,1];

ppr2.cp = [-1 -0.3; 1 -0.3];
ppr2.deg = 1;
ppr2.ab = [0,1];

%curv2_ppbezier_plot(ppr1, 30, 'r', 2);
%curv2_ppbezier_plot(ppr2, 30, 'r', 2);

C = [0, 0.3];
T1r1 = get_mat_trasl(-C);
T1r2 = get_mat_trasl(C);
T2r1 = get_mat_trasl([0.32, 0]);
T2r2 = get_mat_trasl([-0.32, 0]);
R = get_mat2_rot(pi/2);

M1 = T2r1*R*T1r1;
M2 = T2r2*R*T1r2;

ppr1.cp = point_trans(ppr1.cp, M1);
ppr2.cp = point_trans(ppr2.cp, M2);

curv2_ppbezier_plot(ppr1, mp, 'r', 2);
curv2_ppbezier_plot(ppr2, mp, 'r', 2);

point_plot(ppr1.cp(1,:), 'ko', 3);
point_plot(ppr2.cp(1,:), 'ko', 3);

%% Calcolo delle intersezioni con prove di identificazione dei punti di intersezione:
[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppr1, ppP_intern);
IP1P2_r1 = IP1P2_r1'; % Traspongo

fprintf('\n=== PUNTI DI INTERSEZIONE SEGMENTO DX ===\n');
for i = 1:length(t1_r1)
    fprintf('IP1P2_dx %i° = %e %e\n',i, IP1P2_r1(i, :));
end

fprintf("\nINTERSEZIONE TRA : ppr1  -  ppP_intern\n");
% Punto in basso a dx di intersezione (ppr1)
fprintf("- ppr1 t1_r1(1)(%f) = %f %f \n",t1_r1(1), decast_val(ppr1, t1_r1(1)));
% Punto in alto a dx di intersezione (ppr1)
fprintf("- ppr1 t1_r1(2)(%f) = %f %f \n",t1_r1(2), decast_val(ppr1, t1_r1(2)));
% Punto in basso a dx di intersezione (ppP_intern)
fprintf("- ppP_intern t2_r1(1)(%f) = %f %f \n",t2_r1(1), decast_val(ppP_intern, t2_r1(1)));
% Punto in alto a dx di intersezione (ppP_intern)
fprintf("- ppP_intern t2_r1(2)(%f) = %f %f \n",t2_r1(2), decast_val(ppP_intern, t2_r1(2)));

point_plot(IP1P2_r1(1,:), 'ko', 10, 'k', 'k', 8);
point_plot(IP1P2_r1(2,:), 'ro', 10, 'r', 'r', 8);

[IP1P2_r2, t1_r2, t2_r2] = curv2_intersect(ppr2, ppP_intern);
IP1P2_r2 = IP1P2_r2'; % Traspongo

fprintf('\n=== PUNTI DI INTERSEZIONE SEGMENTO SX ===\n');
for i = 1:length(t1_r1)
    fprintf('IP1P2_sx %i° = %e %e\n',i, IP1P2_r2(i, :));
end

fprintf("\nINTERSEZIONE TRA : ppr2  -  ppP_intern\n");
% Punto in basso a sx di intersezione (ppr1)
fprintf("- ppr2 t1_r2(1)(%f) = %f %f \n",t1_r2(1), decast_val(ppr2, t1_r2(1))); % Questo mi interessa
% Punto in alto a sx di intersezione (ppr1)
fprintf("- ppr2 t1_r2(2)(%f) = %f %f \n",t1_r2(2), decast_val(ppr2, t1_r2(2))); % Questo mi interessa
% Punto in basso a dx di intersezione (ppP_intern)
fprintf("- ppP_intern t2_r2(1)(%f) = %f %f \n",t2_r2(1), decast_val(ppP_intern, t2_r2(1)));
% Punto in alto a dx di intersezione (ppP_intern)
fprintf("- ppP_intern t2_r2(2)(%f) = %f %f \n",t2_r2(2), decast_val(ppP_intern, t2_r2(2)));

point_plot(IP1P2_r2(1,:), 'go', 10, 'g', 'g', 8);
point_plot(IP1P2_r2(2,:), 'bo', 10, 'b', 'b', 8);

%% Suddivisioni

open_figure(2);
hold on;

curv2_ppbezier_plot(ppP, mp, 'k', 3);
% Si ricorda che ppP (circonferenza) NON è una curva chiusa!

%% Parte Destra
[p1_sx, p1_dx] = ppbezier_subdiv(ppP_intern, t2_r1(1));
%curv2_ppbezier_plot(p1_dx, mp, 'r', 2);
%curv2_ppbezier_plot(p1_sx, mp, 'b', 2);

[p1_1_sx, p1_1_dx] = ppbezier_subdiv(ppP_intern, t2_r1(2));
%curv2_ppbezier_plot(p1_1_dx, mp, 'r', 2);
%curv2_ppbezier_plot(p1_1_sx, mp, 'b', 2);

union_dx = curv2_mdppbezier_join(p1_dx, p1_1_sx, tol);
union_dx = curv2_mdppbezier_close(union_dx);

union_dx_points = curv2_mdppbezier_plot(union_dx, -mp, 'k', 3);
point_fill(union_dx_points,[1, 0, 0]);

%% Parte Sinistra
[p2_sx, p2_dx] = ppbezier_subdiv(ppP_intern, t2_r2(1));
%curv2_ppbezier_plot(p2_dx, mp, 'r', 2);
%curv2_ppbezier_plot(p2_sx, mp, 'b', 2);

[p2_1_sx, p2_1_dx] = ppbezier_subdiv(p2_sx, t2_r2(2));
%curv2_ppbezier_plot(p2_1_dx, mp, 'r', 2);
%curv2_ppbezier_plot(p2_1_sx, mp, 'b', 2);

union_sx = curv2_mdppbezier_close(p2_1_dx);

union_sx_points = curv2_mdppbezier_plot(union_sx, -mp, 'k', 3);
point_fill(union_sx_points,[0.2, 0.7, 0.2]);

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

function [x,y,xp,yp]=cp2_circle(t)
%espressione parametrica della curva circonferenza
x = cos(t);
y = sin(t);
xp = -sin(t);
yp = cos(t);
end
