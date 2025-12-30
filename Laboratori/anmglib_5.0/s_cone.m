function [x,y,z]=s_cone(u,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=s_cone(u,v)
%Definizione parametrica sella superficie laterare di
%un tronco di cono
%u,v   --> valori parametrici in [0,2]x[0,2*pi]
%x,y,z --> punto 3D della superficie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
uu=2-u;
x = 0.5*uu*cos(v);
y = 0.5*uu*sin(v);
z = u;
return
