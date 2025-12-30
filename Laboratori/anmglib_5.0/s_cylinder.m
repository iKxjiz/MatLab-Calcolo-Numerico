function [x,y,z]=s_cylinder(u,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=s_cylinder(u,v)
%Definizione parametrica sella superficie laterare di
%un cilindro
%u,v   --> valori parametrici in [0,2]x[0,2*pi]
%x,y,z --> punto 3D della superficie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x = cos(v);
y = sin(v);
z = u;
return
