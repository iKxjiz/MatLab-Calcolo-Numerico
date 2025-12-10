function [x,y,z] = solid_sphere_plot(O,r,nu,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function solid_sphere_plot(O,r,nu,nv,type,varargin)
%Disegna un solido elementare: sphere
%si tratta di una sfera di centro O e raggio r;
%O --> punto 3D che definisce il centro della sfera
%r --> raggio della sfera
%nu,nv  --> numero punti griglia di valutazione per ogni faccia
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname 
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong' 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=linspace(0,pi,nu);
v=linspace(0,2*pi,nv);
for i=1:nu
   for j=1:nv
        [x(i,j),y(i,j),z(i,j)]=s_sphere_param(O,r,u(i),v(j));
    end
end

mesh_surf_plot(x,y,z,type,varargin{:});


function [x,y,z]=s_sphere_param(O,r,u,v)
%sfera di centro O, raggio r giacente
x=O(1)+r*cos(u)*sin(v);
y=O(2)+r*sin(u)*sin(v);
z=O(3)+r*cos(v);

return
