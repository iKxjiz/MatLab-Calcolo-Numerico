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
grid on;

n = 20;
a = 0;
b = 1;
mp = 100;
tol = 1.0e-2;
param=0;

%Determinare la circonferenza per interpolazione di Hermite con una curva
%cubica a tratti ppP
t = chebyshev2(0, 2*pi, n + 1);
[x, y, xp, yp] = cp2_circle(t);
ppP = curv2_bezier_interp([x', y'], 0, 2*pi, 2);

S = get_mat_scale([0.97, 0.97]);

ppP_intern = ppP;
ppP_intern.cp = point_trans(ppP_intern.cp, S);
% point_plot(ppP_intern.cp(3,:), 'ko', 10, 'k', 'k', 8);
% point_plot(ppP_intern.cp(end - 2, :), 'ro', 10, 'r', 'r', 8);

ppP_intern = curv2_bezier_reverse(ppP_intern);

curv2_ppbezier_plot(ppP, mp, 'b', 2);
curv2_ppbezier_plot(ppP_intern, mp, 'b', 2);

r1 = [-1 0.3; 1 0.3];
r2 = [-1 -0.3; 1 -0.3];

ppr1 = curv2_bezier_reverse(curv2_bezier_interp(r1,0,1,param));
ppr2 = curv2_bezier_reverse(curv2_bezier_interp(r2,0,1,param));

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

% Calcolo delle intersezioni :
[IP1P2_r1, t1_r1, t2_r1] = curv2_intersect(ppP_intern, ppr1);
%decast_val(ppr1, t1_r1(1))
%decast_val(ppr1, t1_r1(2))
%decast_val(ppr2, t2_r1(1))
%decast_val(ppr2, t2_r1(2))

IP1P2_r1 = IP1P2_r1';

point_plot(IP1P2_r1(1,:), 'ko', 10, 'k', 'k', 8);
point_plot(IP1P2_r1(2,:), 'ro', 10, 'r', 'r', 8);


if (length(t1_r1)>0)
    % Visualizza i punti di intersezione trovati
    point_plot(IP1P2_r1,'go',1,'g','g',8);
    % Stampa informazioni sulle intersezioni
    fprintf('IP1P2 = %e %e\n',IP1P2_r1);
    fprintf('t1 = %e\n',t1_r1);
    fprintf('t2 = %e\n',t2_r1);
end

%--------------------------------------------------------------------------
% ANALISI DETTAGLIATA DELL'ORDINE
%--------------------------------------------------------------------------
fprintf('\n=== ANALISI ORDINE INTERSEZIONI ===\n');
fprintf('ppP_intern.ab = [%.4f, %.4f]\n', ppP_intern.ab);

% Valuta i punti sulla circonferenza ai parametri delle intersezioni
P1_at_t1_1 = decast_val(ppP_intern, t1_r1(1));
P1_at_t1_2 = decast_val(ppP_intern, t1_r1(2));

fprintf('\nPunto 1 (t=%.4f):\n', t1_r1(1));
fprintf('  Coordinate: [%.4f, %.4f]\n', P1_at_t1_1);
fprintf('  Y-coord: %.4f %s\n', P1_at_t1_1(2), ...
    ternary(P1_at_t1_1(2) > 0, '(ALTO)', '(BASSO)'));

fprintf('\nPunto 2 (t=%.4f):\n', t1_r1(2));
fprintf('  Coordinate: [%.4f, %.4f]\n', P1_at_t1_2);
fprintf('  Y-coord: %.4f %s\n', P1_at_t1_2(2), ...
    ternary(P1_at_t1_2(2) > 0, '(ALTO)', '(BASSO)'));

% Calcola l'angolo sulla circonferenza
angle1 = atan2(P1_at_t1_1(2), P1_at_t1_1(1)) * 180/pi;
angle2 = atan2(P1_at_t1_2(2), P1_at_t1_2(1)) * 180/pi;

fprintf('\nAngoli sulla circonferenza:\n');
fprintf('  Punto 1: %.1f gradi\n', angle1);
fprintf('  Punto 2: %.1f gradi\n', angle2);
fprintf('  Differenza: %.1f gradi\n', abs(angle2-angle1));

if t1_r1(1) < t1_r1(2)
    fprintf('\n✓ ORDINE ANTIORARIO CONFERMATO\n');
    fprintf('  (t cresce da %.4f a %.4f)\n', t1_r1(1), t1_r1(2));
else
    fprintf('\n✗ ORDINE ORARIO\n');
    fprintf('  (t decresce da %.4f a %.4f)\n', t1_r1(1), t1_r1(2));
end

% Funzione helper
function result = ternary(condition, true_val, false_val)
if condition
    result = true_val;
else
    result = false_val;
end
end

pause

% PROVE DA FARE :

% Breve aggiunta / nota personale :
%val1_bez1_prima_interz = decast_val(bez1, t1(1))
%val1_bez1_seconda_interz = decast_val(bez1, t1(2))
%val2_bez2_prima_interz = decast_val(bez2, t2(1))
%val2_bez2_seconda_interz = decast_val(bez2, t2(2))
%IP1P2 % sono i punti di intersezione delle due curve

ppP_intern.ab

t1 = linspace(ppr1.ab(1), ppr1.ab(2), 100);
tr = (t1-ppr1.ab(1))./(ppr1.ab(2)-ppr1.ab(1));
rx = decast_val(ppr1, tr);
t2 = linspace(ppP_intern.ab(1), ppP_intern.ab(2), 100);
tc = (t2-ppP_intern.ab(1))./(ppP_intern.ab(2)-ppP_intern.ab(1));
cx = decast_val(ppP_intern, tc);

open_figure(3);
axis_plot(1.5, 0.125);
grid on;

point_plot(rx, 'k', 5);
point_plot(cx, 'b', 5);


function x=chebyshev2( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1
%punti di Chebishev seconda specie
for i=0:n
    x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
end
end