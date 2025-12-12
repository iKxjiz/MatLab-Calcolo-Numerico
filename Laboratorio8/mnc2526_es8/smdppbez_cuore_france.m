%script di esempio
function main()
close all
clc
open_figure(1);

%carica curva di Bézier cuore di grado 9
bezP=curv2_bezier_load('c2_bezier_heart.db');
a=bezP.ab(1);
b=bezP.ab(2);
param = 0;

np=100;
curv2_bezier_plot(bezP,np,'b-',1.5);
%point_plot(bezP.cp(1:2, :), 'ko-', 2); % primo e secondo punto per il verso della curva

n = 6; %Grado
t = linspace(a, 0.5*(a+b), n+1);
Q = ppbezier_val(bezP, t);
point_plot(Q, 'bo', 2);

bezQ = curv2_bezier_interp(Q, a, b, param);
curv2_bezier_plot(bezQ, np, 'g');

bezR = bezQ;
S = get_mat2_symm([0 0], [0 1]);

bezR.cp = point_trans(bezR.cp, S);
curv2_bezier_plot(bezR, np, 'r');

tol = 1.0e-2;
ppP = curv2_mdppbezier_join(bezQ, bezR, tol);

mdppbezQ = curv2_bezier_offset(bezQ, 0.009);
curv2_mdppbezier_plot(mdppbezQ, np, 'm', 3);

% ridefinisco il grado
if length(mdppbezQ.deg)>1
    mdppbezQ.deg = mdppbezQ.deg(1);
end

% segmento verticale
ppL1.cp = [0.055 0; 0.055 0.4];
ppL1.deg = 1;
ppL1.ab = [0,1];
curv2_ppbezier_plot(ppL1, np, 'b', 2);

[IP1P2, t1, t2] = curv2_intersect(mdppbezQ, ppL1);
[ppsx, ppR] = ppbezier_subdiv(mdppbezQ, t1(1));
[ppR, ppdx] = ppbezier_subdiv(ppR, t1(2));

[ppsx, ppL1] = ppbezier_subdiv(ppL1, t2(1));
[ppL1, ppdx] = ppbezier_subdiv(ppL1, p2(2));

ppS = curv2_mdppbezier_join(ppR, ppL1, tol);
curv2_mdppbezier_plot(ppS, np, 'b', 3);

ppT = ppS;
ppT.cp =

