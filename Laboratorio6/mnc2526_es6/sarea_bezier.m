%script sarea_bezier.m
%calcolo dell'area di una curva 2D di Bezier
clear
close all

open_figure(1);
axis_plot(3,0.2);

%definizione di una curva di Bézier
a=0; b=1;
bezP.cp=[0.5,1.25;0,2.5;2.5,2.5;2.5,0;0,0;0.5,1.25];
bezP.deg=length(bezP.cp(:,1))-1;
bezP.ab = [a b];

%disegno della curva e suoi punti di controllo
curv2_bezier_plot(bezP,50,'b',2);
point_plot(bezP.cp,'k-o',1);

%calcolo area della curva e sua stampa
val=curv2_bezier_area(bezP);
if (val < 0)
    bezP=curv2_bezier_reverse(bezP);
    val=-val;
end
fprintf('Area della curva: %e\n',val); 
