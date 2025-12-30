%main di esempio per visualizzazione curva di Bezier a tratti
clear
close all
col=['r','g','b','k','m','c','y','r','g','b','k','m','c','y'];
open_figure(2);
axis_plot(1.25,0.125);

%curva da file
mdppP=curv2_mdppbezier_load('mdppbez_square_smooth.db');

curv2_mdppbezier_plot(mdppP,40,'b',2);
% point_plot(mdppP.cp,'r-o',1.5);

val = curv2_mdppbezier_len(mdppP);
fprintf('Lunghezza della curva: %e\n',val);

%scaliamo ora la curva affinché abbia lunghezza unitaria
s=1/val;
S = get_mat_scale([s,s]);
mdppP.cp = point_trans(mdppP.cp, S);

%disegniamo curva scalata
curv2_mdppbezier_plot(mdppP,40,'r-',2);

%verifica: calcoliamo area curva scalata
val = curv2_mdppbezier_len(mdppP);
fprintf('Lunghezza della curva: %e\n',val);

