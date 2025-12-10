%main di esempio per visualizzazione curva di Bezier a tratti
clear
close all
col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(1,0.125);

%curva da file
ppP=curv2_ppbezier_load('ppbez_square_smooth.db');

curv2_mdppbezier_plot(ppP,40,'b',2);
% point_plot(ppP.cp,'r-o',1.5);

val = curv2_ppbezier_len(ppP);
fprintf('Lunghezza della curva: %e\n',val);

%scaliamo ora la curva affinché abbia lunghezza unitaria
s=1/val;
B=mean(ppP.cp(1:end-1,:));
%definisce matrice di traslazione
T=get_mat_trasl(-B);
%definisce matrice di scala
S=get_mat_scale([s,s]);
%definisce matrice di rotazione
R=get_mat2_rot(pi/3);
%definisce matrice inversa di traslazione
Tinv=get_mat_trasl(B);
% M=Tinv*R*S*T;
M=Tinv*S*T;
ppP.cp=point_trans(ppP.cp,M);

curv2_ppbezier_plot(ppP,40,'r-',2);

val = curv2_ppbezier_len(ppP);
fprintf('Lunghezza della curva: %e\n',val);

