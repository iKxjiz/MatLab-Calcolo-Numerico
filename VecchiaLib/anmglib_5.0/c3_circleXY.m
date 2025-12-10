function [x,y,z]=c3_circleXY(t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=c3_circleXY(t)
%Definizione parametrica della circonferenza 3D di centro
%l'origine e raggio unitario sul piano XY
%t     --> parametro in [0,2*pi]
%x,y,z --> punto 3D della circonferenza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = cos(t);
y = sin(t);
z = 0;
return
