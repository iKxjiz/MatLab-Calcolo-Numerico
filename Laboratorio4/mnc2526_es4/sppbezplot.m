%script sppbezplot.m per curva di Bezier a tratti
%e visualizzazione dei singoli tratti
clear
close all

%vettore di colori
col=['r','g','b','k','m','c','y','k','r','g','b','k','m','c','y'];
open_figure(1);
axis_plot(1,1/16);

%carica curva dal file c2_ppbez_esse.db
ppP=curv2_ppbezier_load('c2_ppbez_esse.db');

%disegna la curva a tratti e la poligonale
curv2_ppbezier_plot(ppP,40,'b',2);
point_plot(ppP.cp,'r-o',1.5);

open_figure(2);
axis_plot(1,1/16);

%estrae e disegna le singole curve di Bézier (i tratti)
np=length(ppP.ab)-1;
for i=1:np

    % TO DO

end
