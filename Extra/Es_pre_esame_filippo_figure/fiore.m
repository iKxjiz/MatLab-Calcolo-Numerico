close all
clear all

open_figure(1);

function [x, y, xd, yd] = cerchio(t)
    x = cos(t);
    y = sin(t);
    xd = -sin(t);
    yd = cos(t);
end

%% Cerchio base
%Interpolazione cerchio
t = linspace(-pi / 2, 3 * pi/2, 8);
[x, y, xd, yd] = cerchio(t);
Q1 = [x', y'];
ppC = curv2_ppbezierCC1_interp_der(Q1,[xd', yd'], t);

%disegna cerchio
% curv2_ppbezier_plot(ppC,40,'k-',2,'k');

%% Spostamento cerchio 
T=get_mat_trasl([1.1, 1]);
ppC.cp=point_trans(ppC.cp,T);
% curv2_ppbezier_plot(ppC, 30, 'k-');

%% Costruzione cerchi
alfa = 2 * pi / 5;

%cerchio superiore
RS = get_mat2_rot(alfa);
ppS = ppC;
ppS.cp = point_trans(ppS.cp, RS);
% curv2_ppbezier_plot(ppS, 30);

%cerchio inferiore
RI = get_mat2_rot(-alfa);
ppI = ppC;
ppI.cp = point_trans(ppI.cp, RI);
% curv2_ppbezier_plot(ppI, 30);

%% Intersezioni
[IS, ~, ts] = curv2_intersect(ppS, ppC);
[II, ti, ~] = curv2_intersect(ppC, ppI);

% disp(IS');
% disp(II');

%% Unione
[petalo, ~] = ppbezier_subdiv(ppC, ts(2));
[~, petalo] = ppbezier_subdiv(petalo, ti(2));
% curv2_ppbezier_plot(petalo, 30, 'k-');

mangala = petalo;
for i = 1: 4
    petalo.cp = point_trans(petalo.cp, RS);
    mangala = curv2_ppbezier_join(mangala, petalo, 1.0e-2);
end

% curv2_ppbezier_plot(mangala, 30, 'k-');

%% Fiore rosso
Px = curv2_ppbezier_plot(mangala, -30);
point_fill(Px, 'r');

%% Fiore blu
R = get_mat2_rot(alfa/2);
S = get_mat_scale([0.65, 0.65]);
M = S * R;
mangala.cp = point_trans(mangala.cp, M);

Px = curv2_ppbezier_plot(mangala, -30);
point_fill(Px, 'b');

%% Fiore bianco
S = get_mat_scale([0.45, 0.45]);
mangala.cp = point_trans(mangala.cp, S);

Px = curv2_ppbezier_plot(mangala, -30);
point_fill(Px, 'w');

%% Cerchio rosso
[x, y] = circle2_plot([0, 0], 0.25, -30);
point_fill([x', y'], 'r');
