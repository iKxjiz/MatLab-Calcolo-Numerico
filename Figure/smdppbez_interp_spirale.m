% =========================================================================
% SCRIPT: Doppia spirale con cerchi crescenti
% =========================================================================
% Disegna due spirali simmetriche (positiva e negativa) con cerchi di
% raggio crescente lungo la spirale
% =========================================================================

close all;
clear;
clc;

open_figure(1);
col = [230, 230, 230] / 255;
set(gca, 'Color', col);

%% ========================================================================
% PARAMETRI
% =========================================================================

np = 60;
tol = 1.0e-4;
a = 0.1;        % Fattore di scala spirale
b = 9;          % Fattore di crescita spirale
nPunti = 41;    % Numero punti spirale
nCerchio = 16;  % Punti per cerchio

%% ========================================================================
% GENERAZIONE PUNTI SPIRALE
% =========================================================================

p = linspace(-3*pi, pi/2, nPunti);
t = linspace(0, 10*pi, 1000);

% Calcolo punti spirale positiva e negativa
Crf = zeros(nPunti, 2);
for i = 1:nPunti
    [Crf(i,1), Crf(i,2)] = c2_circle(p(i), a + b*t(i));
end
CrfNeg = -Crf;

point_plot(Crf);
point_plot(CrfNeg, 'r');

%% ========================================================================
% INTERPOLAZIONE SPIRALE CON BÉZIER A TRATTI
% =========================================================================

% Primo tratto
X = Crf(1:5, :);
spirale = curv2_bezier_interp(X, 0, 1, 2);
curv2_ppbezier_plot(spirale, np, 'r');

% Unione dei tratti successivi (gruppi di 4 punti con sovrapposizione)
indici = [5, 9, 13, 17, 21, 25, 29, 33, 37];

for i = 1:length(indici)
    idx = indici(i);
    X = Crf(idx:idx+4, :);
    tratto = curv2_bezier_interp(X, 0, 1, 2);
    curv2_mdppbezier_plot(tratto, np, 'r');
    spirale = curv2_mdppbezier_join(tratto, spirale, tol);
end

curv2_mdppbezier_plot(spirale, np, 'g', 3);

%% ========================================================================
% CERCHI LUNGO LE SPIRALI
% =========================================================================

m = linspace(0, 2*pi, nCerchio);

for i = 1:nPunti
    raggio = (a + b*t(i)) / 7;

    % Cerchio base
    [cx, cy] = c2_circle(m, raggio);
    Cerchio = [cx', cy'];

    % Cerchio positivo (traslato sulla spirale positiva)
    CerchioPos = Cerchio + Crf(i, :);
    bezCerPos = curv2_bezier_interp(CerchioPos, 0, 1, 0);
    xy = curv2_mdppbezier_plot(bezCerPos, np, 'k');
    fill(xy(:,1), xy(:,2), 'r');
    curv2_mdppbezier_plot(bezCerPos, np, 'b', 2);

    % Cerchio negativo (traslato sulla spirale negativa)
    CerchioNeg = -Cerchio + CrfNeg(i, :);
    bezCerNeg = curv2_bezier_interp(CerchioNeg, 0, 1, 0);
    xy = curv2_mdppbezier_plot(bezCerNeg, np, 'k');
    fill(xy(:,1), xy(:,2), 'r');
    curv2_mdppbezier_plot(bezCerNeg, np, 'b', 2);
end

%% ========================================================================
% FUNZIONE LOCALE
% =========================================================================

function [x, y] = c2_circle(t, r)
% Circonferenza di raggio r
x = r * cos(t);
y = r * sin(t);
end