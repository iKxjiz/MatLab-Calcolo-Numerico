function [x,y,z]=s_sphere_param(O,r,u,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=s_sphere_param(O,r,u,v)
%Definizione parametrica della superficie sferica di centro O
%e raggio r
%u,v   --> valori parametrici in [0,2*pi]x[0,2*pi]
%x,y,z --> punto 3D della superficie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x=O(1)+r*cos(u)*sin(v);
y=O(2)+r*sin(u)*sin(v);
z=O(3)+r*cos(v);

return
