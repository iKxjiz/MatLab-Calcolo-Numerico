%script sppbezierinterp_curve2d_bicorn.m
%Interpolazione polinomiale con curve di Bezier di due funzioni e
%poi join per definire una curva Bézier a tratti di bordo
function main()
close all
clc
col=['r','g','b','k'];

open_figure(1);
axis_plot(1.5,0.125)

%Disegno delle due funzioni date
mp=150;
a=-1;
b=1;
[x,y1]=curv2_plot('c2_bicorn1',a,b,mp,'b-',1.5);
[x,y2]=curv2_plot('c2_bicorn2',a,b,mp,'r-',1.5);



end