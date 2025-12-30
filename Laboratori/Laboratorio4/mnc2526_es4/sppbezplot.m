%script sppbezplot.m per curva di Bezier a tratti
%e visualizzazione dei singoli tratti
clear
close all

%vettore di colori
vcol=['r','g','b','k','m','c','y','k','r','g','b','k','m','c','y'];
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
np=length(ppP.ab)-1; % -1 perché ab ha un punto in più che indica la fine dell'ultimo tratto
for i=1:np
    st = (i-1)*ppP.deg + 1;
    fn = i*ppP.deg + 1;
    col = vcol(i);
    point_plot(ppP.cp(st:fn, :),col,1.5);
    cbez.deg = ppP.deg;
    %cbez.cp = [ppP.cp(i,:); ppP.cp(i+1, :)];
    cbez.cp = ppP.cp(st:fn, :);
    cbez.ab = ppP.ab(i:i+1);
    curv2_ppbezier_plot(cbez,40, col, 2);
end
% "piecewise curve" (curva di Bézier a tratti) :
% ottenuta unendo insieme più curve 2D di Bézier di stesso grado