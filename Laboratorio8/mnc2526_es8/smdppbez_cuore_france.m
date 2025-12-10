%script di esempio
function main()
close all
open_figure(1);

%carica curva di Bézier cuore di grado 9
bezP=curv2_bezier_load('c2_bezier_heart.db');
a=bezP.ab(1);
b=bezP.ab(2);

np=61;
curv2_bezier_plot(bezP,np,'b-',1.5);

%TO DO