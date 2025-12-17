% =========================================================================
% SCRIPT: Bandiera della Lituania con bordo a forma di cuore
% =========================================================================
% Disegna la bandiera lituana (giallo-verde-rosso) all'interno di un cuore
% usando curve di Bézier e intersezioni con rettangoli
% =========================================================================

close all;
clear all;
clc;

% PARAMETRI

np = 40;
param = 0;
tol = 1.0e-2;

% CUORE ESTERNO (bordo nero)

open_figure(1);

% Campionamento con punti di Chebyshev
% t = linspace(-pi/2, 3*pi/2, 100); % oppure si usa chebyshev2
t = chebyshev2(-pi/2, 3*pi/2, 100);
[x, y] = cuore(t);
Q = [x', y'];

% Interpolazione Hermite C1
ppC = curv2_ppbezierCC1_interp(Q, -pi/2, 3*pi/2, param);
curv2_ppbezier_plot(ppC, np, 'k-', 2, 'k');

% CUORE SCALATO (per intersezioni)

ppCS = ppC;
S = get_mat_scale([0.96, 0.96]);
ppCS.cp = point_trans(ppCS.cp, S);
curv2_ppbezier_plot(ppCS, np, 'k-', 2, 'k');

% RETTANGOLO (per suddividere le fasce)

x = 20;
y = 4;
ppR.cp = [x, y; -x, y; -x, -y; x, -y; x, y];
ppR.ab = linspace(0, 1, 5);
ppR.deg = 1;

% Eleva il grado a 3 per compatibilità con il cuore
Px = curv2_ppbezier_plot(ppR, -np);
ppR = curv2_ppbezierCC1_interp(Px, min(Px(:,1)), max(Px(:,1)), param);
curv2_ppbezier_plot(ppR, np, 'k-', 2, 'k');

% INTERSEZIONI

[IP1P2, t1, t2] = curv2_intersect(ppCS, ppR);
IP1P2 = IP1P2';
point_plot(IP1P2, 'bo');

% FASCIA ALTA (gialla)

% Suddividi cuore
[~, cdx] = ppbezier_subdiv(ppCS, t1(1));
[csx, ~] = ppbezier_subdiv(cdx, t1(4));

% Suddividi rettangolo
[~, rdx] = ppbezier_subdiv(ppR, t2(1));
[rsx, ~] = ppbezier_subdiv(rdx, t2(4));

% Unisci
ppA = curv2_mdppbezier_join(csx, rsx, tol);

% FASCIA BASSA (rossa)

% Suddividi cuore
[csx, ~] = ppbezier_subdiv(ppCS, t1(2));
[~, cdx] = ppbezier_subdiv(csx, t1(3));

% Suddividi rettangolo
[rsx, ~] = ppbezier_subdiv(ppR, t2(2));
[~, rdx] = ppbezier_subdiv(rsx, t2(3));

% Unisci
ppB = curv2_mdppbezier_join(cdx, rdx, tol);

% DISEGNO FINALE

open_figure(2);

% Fascia centrale (verde)
Pcentrale = curv2_mdppbezier_plot(ppCS, -np);
point_fill(Pcentrale, [0, 0.5, 0]);

% Fascia alta (gialla)
Palta = curv2_mdppbezier_plot(ppA, -np);
point_fill(Palta, 'y');

% Fascia bassa (rossa)
Pbassa = curv2_mdppbezier_plot(ppB, -np);
point_fill(Pbassa, 'r');

% Bordo cuore esterno
curv2_ppbezier_plot(ppC, np, 'k-', 2, 'k');

% FUNZIONI LOCALI

function [x, y] = cuore(t)
% Parametrizzazione cuore
x = 16 .* sin(t).^3;
y = 13 .* cos(t) - 5 .* cos(2*t) - 2 .* cos(3*t) - cos(4*t);
end

function x = chebyshev2(a, b, n)
% Punti di Chebyshev di seconda specie in [a,b]
for i = 0:n
    x(i+1) = 0.5*(a+b) + 0.5*(a-b)*cos(i*pi/n);
end
end