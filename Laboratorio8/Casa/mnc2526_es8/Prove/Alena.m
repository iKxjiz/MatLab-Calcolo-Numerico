function main()
close all
clc
open_figure(1);

%Disegno delle due funzioni date
tol = 1.0e-2;
n = 20;
mp=100; %come 150 curve di bezier esagerato %numero di punti in cui valuto la curva
a=0;
b=2*pi;
t = chebyshev2(a, b, n + 1);
[x, y] = cp2_circle(t);
Q=[x',y'];

%INTERPOLAZIONE
ppQtot = curv2_bezier_interp(Q, a, b, 0);
ppQtot_x = curv2_bezier_plot(ppQtot, mp, 'b');

%SCALATURA
S = get_mat_scale([0.90, 0.90]);
% Trasformo i punti di controllo
% Creo una nuova curva con punti di controllo scalati
P_scale = ppQtot;
P_scale.cp = point_trans(ppQtot.cp, S);
% Plot curva scalata
curv2_bezier_plot(P_scale, mp, 'b'); %disegno della curva scalata

%Retta superiore sottoforma di Bezier
bezS.deg = 1;
bezS.ab = [0 1];
bezS.cp = [-1 0.2; 1 0.2];
curv2_bezier_plot(bezS, mp, 'r-');

%Retta inferiore sottoforma di Bezier
bezI.deg = 1;
bezI.ab = [0 1];
bezI.cp = [-1 -0.2; 1 -0.2];
curv2_bezier_plot(bezI, mp, 'r-');

%CALCOLO DEI PUNTI DI INTERSEZIONE DELLE CURVE
[IP1P2, t1, t2] = curv2_intersect(P_scale,bezS);
IP1P2 = IP1P2';
[IP3P4, t3, t4] = curv2_intersect(P_scale,bezI);
IP3P4 = IP3P4';

point_plot(IP1P2(1,:), 'ko', 10, 'k', 'k', 4);
point_plot(IP1P2(2,:), 'ro', 10, 'r', 'r', 4);
point_plot(IP3P4(1,:), 'go', 10, 'g', 'g', 4);
point_plot(IP3P4(2,:), 'bo', 10, 'b', 'b', 4);

if (length(t1)>0) %procedi solo se esiste almeno una intersezione
    fprintf('IP1P2 = %e %e\n',IP1P2');
    fprintf('t1 = %e\n',t1);
    fprintf('t2 = %e\n',t2);
end

if (length(t3)>0) %procedi solo se esiste almeno una intersezione
    fprintf('IP1P2 = %e %e\n',IP3P4');
    fprintf('t1 = %e\n',t3);
    fprintf('t2 = %e\n',t4);
end

open_figure(2);
%curv2_bezier_plot(ppQtot, mp, 'b');
point_fill(ppQtot_x, 'r', 'b', 3);

[~,p1]=decast_subdiv(P_scale,t1(1));
[p1,~]=decast_subdiv(p1,t3(1));
%curv2_bezier_plot(p1, 100, 'r');

Sy = get_mat2_symm([0 0], [0 1]);
p2 = p1;
p2.cp = point_trans(p1.cp, Sy);
%curv2_bezier_plot(p2, 100, 'r');

p3 = curv2_mdppbezier_join(p1, p2, tol);
%curv2_mdppbezier_plot(p3, 100, 'g');
% Chiudo la curva
p4 = curv2_mdppbezier_close(p3);
punti_centrale = curv2_mdppbezier_plot(p4, -mp, 'g', 2);
% bianco con bordi blu
point_fill(punti_centrale, 'white', 'b', 3);

end

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