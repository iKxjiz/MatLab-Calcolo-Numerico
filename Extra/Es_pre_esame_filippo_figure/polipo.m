function polipo
clear all;
close all;
open_figure(1);
axis_plot(5, 1);

% Q = [
%     -2.07, 2.07;
%     -1.2, 2.8;
%     0.396, 3.739;
%     1.22, 3.51;
%     1.473, 1.513;
%     2.11, 0.38;
%     3.08, 0.60;
%     4.144, 1.299;
%     5, 2.07];

%% Curva rossa per interpolazione
Q = [
    0,0;
    2.04, 0.21;
    3.35, 1.3;
    1.75, 3.38;
    1.89, 4.29;
    2.95, 4.78;
    5, 5];
a = min(Q(:, 1));
b = max(Q(:, 1));
rossa = curv2_ppbezierCC1_interp(Q, a, b, 0);
curv2_ppbezier_plot(rossa, 30, 'r', 1.5);

%% Curva blu
T = get_mat_trasl([-5, 0]);
blu = rossa;
blu.cp = point_trans(blu.cp, T);
blu.cp(:, 1) = -blu.cp(:,1);
T(1:2, 3) = - T(1:2, 3);
blu.cp = point_trans(blu.cp, T);
R = get_mat2_rot(pi/4);
T = get_mat_trasl([-5, -5]);
Tinv = get_mat_trasl([-2.07, 2.07]);
M = Tinv * R * T;
blu.cp = point_trans(blu.cp, M);
curv2_ppbezier_plot(blu, 30, 'b', 1.5);

%% Intersezione e unione
[~, t1, t2] = curv2_intersect(rossa, blu);

[~, rossa] = ppbezier_subdiv(rossa, t1);
[~, blu] = ppbezier_subdiv(blu, t2);

braccio = curv2_mdppbezier_join(rossa, blu, 1.0e-2);
% curv2_ppbezier_plot(braccio, 30, 'g', 1.5);


%% Figura finale
open_figure(2);
alfa = 2 * pi/8;
R = get_mat2_rot(alfa);
T = get_mat_trasl([-5, 5]);
braccio.cp = point_trans(braccio.cp, T);
finale = braccio;

for i = 1:7
    braccio.cp = point_trans(braccio.cp, R);
    finale = curv2_mdppbezier_join(finale, braccio, 0.3);

    % curv2_ppbezier_plot(finale, 30, 'g', 1.5);

end

Tinv = get_mat_trasl([5, -5]);
finale.cp = point_trans(finale.cp, Tinv);

Px = curv2_ppbezier_plot(finale, -30);
point_fill(Px, 'b');

%% Cerchio rosso centrale
t = linspace(0, 2 * pi, 8);
[x, y, xd, yd] = cerchio(t);
ppC = curv2_ppbezierCC1_interp_der([x', y'], [xd', yd'], t);

S = get_mat_scale([5, 5]);
M = Tinv * S;
ppC.cp = point_trans(ppC.cp, M);

Px = curv2_ppbezier_plot(ppC, -30);
point_fill(Px, 'r');

end
function [x, y, xd, yd] = cerchio(t)
x = cos(t);
y = sin(t);
xd = -sin(t);
yd = cos(t);
end