%==========================================================================
% Script: smdppbez_interp_segnale.m
%==========================================================================
% DESCRIZIONE:
% Si vuole riprodurre il disegno di Figura 2 a destra, utilizzando curve
% di B´ezier a tratti multi-grado, ottenute come join di curve di B´ezier
% di interpolazione e/o modellazione.
% Si colorino quindi le regioni delimitate da tali curve per replicare,
% come richiesto, il disegno. Figura 2 ==> segnale di divieto
%==========================================================================
close all;
clear all;
axis equal;
clc

open_figure(1);
grid on;
axis equal;

n = 20;
mp = 100;
tol = 1.0e-6;
param=0;

t = chebyshev2(0, 2*pi, n+1);
[x, y] = cp2_circle(t);
ppP = curv2_ppbezierCC1_interp([x', y'], 0, 2*pi, param);

disp(ppP);

S = get_mat_scale([0.97, 0.97]); % scala per cerchio interno
R = get_mat2_rot(pi/2);
% Effettuo una rotazione sul cerchio interno per fare in modo che il punto
% iniziale della circonfereza (curva non chiusa), sia in alto.

% Matrice composta M:
M = R * S;

ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, M);

r1 = [-1 0.2; 1 0.2];
r2 = [-1 -0.2; 1 -0.2];

ppr1 = curv2_bezier_interp(r1,0,1,param);
ppr2 = curv2_bezier_interp(r2,0,1,param);

curv2_ppbezier_plot(ppP, mp, 'b', 3);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 3);
curv2_ppbezier_plot(ppr1, mp, 'r', 2);
curv2_ppbezier_plot(ppr2, mp, 'r', 2);

%Calcolo delle intersezioni
[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppr1, ppP_intern);
IP1P2_r1 = IP1P2_r1';

[IP1P2_r2, t1_r2, t2_r2] = curv2_intersect(ppr2, ppP_intern);
IP1P2_r2 = IP1P2_r2'; %

point_plot(IP1P2_r1(1,:), 'ko', 10, 'k', 'k', 4);
point_plot(IP1P2_r1(2,:), 'ro', 10, 'r', 'r', 4);

point_plot(IP1P2_r2(1,:), 'go', 10, 'g', 'g', 4);
point_plot(IP1P2_r2(2,:), 'bo', 10, 'b', 'b', 4);

% Informazioni :
fprintf("- ppr1 t1_r1(1)(%f) = %f %f \n",t1_r1(1), decast_val(ppr1, t1_r1(1)));
fprintf("- ppr1 t1_r1(2)(%f) = %f %f \n",t1_r1(2), decast_val(ppr1, t1_r1(2)));
fprintf("- ppP_intern t2_r1(1)(%f) = %f %f \n",t2_r1(1), decast_val(ppP_intern, t2_r1(1)));
fprintf("- ppP_intern t2_r1(2)(%f) = %f %f \n\n",t2_r1(2), decast_val(ppP_intern, t2_r1(2)));

fprintf("- ppr2 t1_r2(1)(%f) = %f %f \n",t1_r2(1), decast_val(ppr2, t1_r2(1)));
fprintf("- ppr2 t1_r2(2)(%f) = %f %f \n",t1_r2(2), decast_val(ppr2, t1_r2(2)));
fprintf("- ppP_intern t2_r2(1)(%f) = %f %f \n",t2_r2(1), decast_val(ppP_intern, t2_r2(1)));
fprintf("- ppP_intern t2_r2(2)(%f) = %f %f \n\n",t2_r2(2), decast_val(ppP_intern, t2_r2(2)));

%Suddivisioni per ottenere la parte centrale
open_figure(2);
axis equal;

ppP_points = curv2_ppbezier_plot(ppP, -mp, 'b', 3);
point_fill(ppP_points, 'r', 'b', 2);

[sx_1, dx_1] = ppbezier_subdiv(ppP_intern, t2_r1(1));
%curv2_ppbezier_plot(sx_1, mp, 'r', 2);
%curv2_ppbezier_plot(dx_1, mp, 'b', 2);

[p1, dx_1_1] = ppbezier_subdiv(dx_1, t2_r2(1));
%curv2_ppbezier_plot(p1, mp, 'r', 2);
%curv2_ppbezier_plot(dx_1_1, mp, 'b', 2);

[sx_2, dx_2] = ppbezier_subdiv(ppP_intern, t2_r2(2));
%curv2_ppbezier_plot(sx_2, mp, 'r', 2);
%curv2_ppbezier_plot(dx_2, mp, 'b', 2);
[p2, dx_2_2] = ppbezier_subdiv(dx_2, t2_r1(2));
%curv2_ppbezier_plot(p2, mp, 'r', 2);
%curv2_ppbezier_plot(dx_2_2, mp, 'b', 2);


% Unioni
bianco1 = curv2_mdppbezier_join(p1, p2, tol);
%curv2_mdppbezier_plot(bianco1, mp, 'b', 2);
bianco1 = curv2_mdppbezier_close(bianco1);
bianco = curv2_mdppbezier_plot(bianco1, -mp, 'b', 2);
% bianco con bordo blu
point_fill(bianco, 'white', 'b', 3);

%curv2_ppbezier_plot(ppr1, mp, 'k', 4);
%curv2_ppbezier_plot(ppr2, mp, 'k', 4);

% Funzioni Locali :
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