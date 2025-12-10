%main di esempio per visualizzazione curva di Bezier a tratti
clear
close all
col=['r','g','b','k','m','c','r','g','b','k','m','c'];
open_figure(2);
axis_plot(1.25,0.125);

%curva da file
mdppP=curv2_mdppbezier_load('mdppbez_square_smooth.db');

curv2_mdppbezier_plot(mdppP,20,'b-',2);

val = curv2_mdppbezier_area(mdppP);

if (val < 0)
    mdppP=curv2_mdppbezier_reverse(mdppP);
    val=-val;
end
fprintf('area della curva: %e\n',val); 

%scaliamo ora la curva affinché abbia area unitaria
s=sqrt(1/val);
%TO DO

%disegniamo curva scalata
curv2_mdppbezier_plot(mdppP,20,'r-',2);

%verifica: calcoliamo area curva scalata
val = curv2_mdppbezier_area(mdppP);
fprintf('area della curva: %e\n',val);

