%script sbezierinterp_p2d.m
%interpolazione di un set di punti 2D con curve di Bezier
clear
close all

col=['r','g','b','k'];
open_figure(1);
axis_plot(3,0.25);

%alcuni set di punti da interpolare (commentare/scommentare)
% Q=[0,2; 1,1; 2,1; 3,2];
% Q=[0,2; 2,1; 1,1; 3,2];
% Q=[0,0; 1,1; 2,2; 3,3];
% Q=[0,2; 1,1; 2,2; 3,1];
%Q=[5.0000   10.0000
%    1.8       8.7
%    1.8       6.2
%    3.2       3.8
%    3.2       1.3
%    0.0       0.0];
Q=[0,2; 1.4,1; 1.6, 1; 2,1; 3,2]; % anche se brutta, cambiando il param si può migliorare
% Fai un Q che fa una cuspide e fai l'interpolazione spiegata con param diversi

% Spiega ogni interpolazione che viene rappresentata (ES : perchè la terza Q è una retta ?)

%disegno punti da interpolare
open_figure();
hold on;
grid on;
axis_plot(11, 1);
point_plot(Q,'ko:',3,'k');

[n m]=size(Q);
x=Q(1:n,1)';
y=Q(1:n,2)';

g=n-1; % definisco il grado del polinomio

% estremi dell'intervallo di interpolazione
a=0;
b=1;
param = 0; % Cosa cambia per param = 1 e param = 2 ?

cbez1 = curv2_bezier_interp(Q, a, b, 0); % Vedi con help
cbez2 = curv2_bezier_interp(Q, a, b, 1);
cbez3 = curv2_bezier_interp(Q, a, b, 2);
%grafico dati (x,y) e valori polinomio interpolante (xv,yv)

%plot(xv,yv,'r-','LineWidth',2);
np = 100;
curv2_ppbezier_plot(cbez1,np, 'r-', 2);
curv2_ppbezier_plot(cbez2,np, 'b-', 2);
curv2_ppbezier_plot(cbez3,np, 'g-', 2);
