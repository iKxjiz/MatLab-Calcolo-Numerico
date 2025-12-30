%script sppbezierinterp_curve2d_bicorn.m
%Interpolazione polinomiale con curve di Bezier di due funzioni e
%poi join per definire una curva Bézier a tratti di bordo
function main()
close all
clc

% Disegno delle due funzioni date

open_figure(1);
axis_plot(1.5,0.125)

mp=100;
a=-1;
b=1;

curv2_plot('c2_bicorn1',a,b,mp,'b-',1.5);
curv2_plot('c2_bicorn2',a,b,mp,'r-',1.5);

% Ricostruiamo la prima curva interpolante
open_figure(2);
axis_plot(1.5,0.125)

% vogliamo interpolare con dei polinomi di grado n, quindi dobbiamo imporre
% n + 1 condizioni (=> n+1 punti di interpolazione). ci pensa chebyshcev2,
% noi gli diamo il grado del polinomio e sarà lui a imporre n+1 condizioni
% (n+1 zeri)
n = 4;

%uso stesso t perché stesso intervallo, altrimenti due t diversi
%t = chebyshev2(a,b,n);
t = linspace(a,b,n+1);

[xq, yq] = c2_bicorn1(t);
[xp, yp] = c2_bicorn2(t);

%definisco struttura di Bezier per la prima curva
% bezQ.deg = n;
% bezQ.ab = [a,b];
%
% %per i punti di controllo devo risolvere il sistema lineare y=Bb
% tt = (t-a) / (b-a); % bernst_val vuole punti in [0,1]
% B1 = bernst_val(n, tt);
% bx=B1\xq';
% by=B1\yq';
%
% bezQ.cp=[bx, by];

Q = [xq', yq'];
bezQ = curv2_bezier_interp(Q, 0, 1, 0);

curv2_bezier_plot(bezQ, mp, 'b');

%disegno il primo punto della curva per il verso di percorrenza
point_plot(bezQ.cp(1,:), 'bo', 1, 'b', 'b', 8);

% Ricostruiamo la seconda curva interpolantes
P = [xp', yp'];

bezP = curv2_bezier_interp(P, 0, 1, 0);

% bezP.deg = n;
% bezP.ab = [a,b];
%
% B2 = bernst_val(n, tt);
% bx=B2\xp';
% by=B2\yp';
%
% bezP.cp=[bx, by];

curv2_bezier_plot(bezP, mp, 'r');
point_plot(bezP.cp(1,:), 'ro', 1, 'r', 'r', 8);

% Otteniamo l'intersezione delle curve
open_figure(3);
axis_plot(1.5,0.125)

[IP1P2, t1, t2] = curv2_intersect(bezP, bezQ);

[sx, bez1] = decast_subdiv(bezP, t1(1));
[bez1, dx] = decast_subdiv(bez1, t1(2));
%curv2_bezier_plot(bezP, mp, 'g', 1.5);

[sx, bez2] = decast_subdiv(bezQ, t2(1));
[bez2, dx] = decast_subdiv(bez2, t2(2));
%curv2_bezier_plot(bezQ, mp, 'c', 1.5);

tol = 1.0e-2;
ppbez1 = curv2_mdppbezier_join(bez2, bez1, tol);
ppbez1 = curv2_mdppbezier_close(ppbez1);
curv2_ppbezier_plot(ppbez1, mp, 'k', 1.5);

% Applichiamo le trasformazioni geometriche
open_figure(4);
set(gca, 'color', [1.0 1.0 0.8]);

% d = punto di arrivo - punto di partenza
d=[0.3, 0] - ppbez1.cp(1,:);
T=get_mat_trasl(d);

ppbez1.cp = point_trans(ppbez1.cp, T);
%curv2_ppbezier_plot(ppbez1, mp,'k',2);

ppbez2 = ppbez1;
ncurv=12; %num+1
teta=linspace(0,2*pi,ncurv);

for i=2:ncurv
    ang = teta(i);
    R=get_mat2_rot(ang);
    ppbez2.cp = point_trans(ppbez1.cp, R);
    P=curv2_ppbezier_plot(ppbez2, -mp, 'b', 1.5);
    point_fill(P, 'g', 'b', 1.5);
end

end