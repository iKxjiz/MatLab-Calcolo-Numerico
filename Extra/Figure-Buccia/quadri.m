close all;
clear all;
function [ppbezQ, T, R] = align_curve(ppbezP)
ncp = length(ppbezP.cp(:, 1)); %numero di punti di controllo
ppbezQ = ppbezP;
T = get_mat_trasl(-ppbezP.cp(1, :));
alfa = -atan2(ppbezP.cp(ncp, 2) - ppbezP.cp(1, 2), ppbezP.cp(ncp, 1) - ppbezP.cp(1, 1));
R = get_mat2_rot(alfa);
M = R*T;
ppbezQ.cp = point_trans(ppbezQ.cp, M);
end


open_figure(1);

%% Costruzione quadro
%parte sinistra bassa
% xp = [0, -0.07, -0.2];
% yp = [0, 0.12, 0.2];
% a = -0.2;
% b = 0;
% pp.ab = [a, b];
% pp.deg = 2;
% tt = (xp-a)./(b-a);
% B = bernst_val(2, tt);
% pp.cp = [linspace(a, b, 3)' , B \ yp'];

%parte sinistra alta
% xp = [-0.2, -0.07, 0];
% yp = [0.2, 0.27, 0.4];
% a = -0.2;
% b = 0;
% pc.ab = [a, b];
% pc.deg = 2;
% tt = (xp-a)./(b-a);
% B = bernst_val(2, tt);
% pc.cp = [linspace(a, b, 3)' , B \ yp'];

%parte sinistra bassa
pp.deg=2;
pp.ab=[0,1];
pp.cp=[0,0;
    -0.06,0.2;
    -0.2,0.2];

% parte sinistra alta
pc.deg=2;
pc.ab=[0,1];
pc.cp=[-0.2,0.2;
    -0.06,0.2;
    0,0.4];



%unione
sinistra=curv2_mdppbezier_join(pp,pc,1.0e-2);
% curv2_ppbezier_plot(sinistra,150,'b');

%riflessione e unione con parte destra
[ppAligned,T,R]=align_curve(sinistra);
T2=ppAligned;
x=ppAligned.cp(:,1);
y=ppAligned.cp(:,2);
ppAligned.cp=[x,-y];
quadro=curv2_mdppbezier_join(T2,ppAligned,1.0e-2);
M=inv(R*T);
quadro.cp=point_trans(quadro.cp,M);
Px=curv2_mdppbezier_plot(quadro,50,'k');

%% circolo esterno

open_figure(2);

T1 = get_mat_trasl([0, -0.2]); %porto il baricentro al centro
T2 = get_mat_trasl([0.95, 0]); %porto il baricentro a destra di 1
quadro.cp = point_trans(quadro.cp, T1);
c2 = quadro;
S = get_mat_scale([1.3, 1.3]);
c2.cp = point_trans(c2.cp, S);
c2.cp = point_trans(c2.cp, T2);
% curv2_ppbezier_plot(c2, 30, 'k');

R = get_mat2_rot(2 * pi / 12);
for i=1:12
    Px = curv2_ppbezier_plot(c2, -30);
    point_fill(Px, 'r', 'b', 2);
    c2.cp=point_trans(c2.cp, R);
end

%% circolo intermedio
c3 = quadro;
S = get_mat_scale([2.2, 2.2]);
% c3.cp = point_trans(c3.cp, S);
T3 = get_mat_trasl([0, 0.6]);
M = T3 * S;
c3.cp = point_trans(c3.cp, M);

R = get_mat2_rot(2 * pi / 5);
for i = 1:5
    c3.cp=point_trans(c3.cp, R);
    Px = curv2_ppbezier_plot(c3, -30);
    point_fill(Px, 'g', 'b', 2);
end

%% circolo interno
c4 = quadro;
S = get_mat_scale([1.6, 1.6]);
T4 = get_mat_trasl([0, 0.32]);
M = T4 * S;
c4.cp = point_trans(c4.cp, M);

R = get_mat2_rot(2 * pi / 4);
for i = 1:4
    c4.cp=point_trans(c4.cp, R);
    Px = curv2_ppbezier_plot(c4, -30);
    point_fill(Px, 'b', 'b', 2);
end