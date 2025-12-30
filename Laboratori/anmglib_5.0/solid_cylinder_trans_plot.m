function [x,y,z] = solid_cylinder_trans_plot(A,B,r,nu,nv,M,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z] = solid_cylinder_trans_plot(A,B,r,nu,nv,M,type,varargin)
%Disegna un solido elementare: cylinder
%si tratta di un cylinder definito dall'asse di estremi A e B 
%e dal raggio r;
%A,B --> punti 3D che definiscono l'asse del cilindro
%r   --> raggio della base
%nu,nv  --> numero punti griglia di valutazione
%M   --> matrice di trasformazione
%type--> tipo di disegno
%      1: mesh hidden-line 
%      2: mesh colorata 
%      3: mesh personalizzabile
%varargin --> se type = 3, specificare manualmente le proprieta' del disegno
%             FaceColor: 'none', 'flat', 'interp', colorname
%             EdgeColor: 'none', 'flat', 'interp', colorname 
%             FaceLightning: 'flat', 'gouraud', 'none', 'phong'
%x,y,z <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
u=linspace(0,2*pi,nu);
v=linspace(0,1,nv);
for i=1:nu
   for j=1:nv
        [x(i,j),y(i,j),z(i,j)]=s_cylinder_param(A,B,r,u(i),v(j));
    end
end

for i=1:nu
 for j=1:nv
  w=[x(i,j),y(i,j),z(i,j),1]';
  w=M*w;
  x(i,j)=w(1);
  y(i,j)=w(2);
  z(i,j)=w(3);
 end
end

mesh_surf_plot(x,y,z,type,varargin{:});

n=B-A;
for j=1:nv
   rr=r*v(j);
   for i=1:nu
        [x(i,j),y(i,j),z(i,j)]=c3_circleXYZ(A,rr,n,u(i));
    end
end

for i=1:nu
 for j=1:nv
  w=[x(i,j),y(i,j),z(i,j),1]';
  w=M*w;
  x(i,j)=w(1);
  y(i,j)=w(2);
  z(i,j)=w(3);
 end
end

mesh_surf_plot(x,y,z,type,varargin{:});

for j=1:nv
   rr=r*v(j);
   for i=1:nu
        [x(i,j),y(i,j),z(i,j)]=c3_circleXYZ(B,rr,n,u(i));
    end
end

for i=1:nu
 for j=1:nv
  w=[x(i,j),y(i,j),z(i,j),1]';
  w=M*w;
  x(i,j)=w(1);
  y(i,j)=w(2);
  z(i,j)=w(3);
 end

mesh_surf_plot(x,y,z,type,varargin{:});
end 
function [x,y,z]=s_cylinder_param(A,B,r,u,v)
%cerchio di centro O, raggio r giacente sul piano
%con normale n per t in [0,2*pi]
n=B-A;
n=n./norm(n,2);
if (n(1)~=0 || n(2)~=0)
    ortn=[-n(2),n(1),0];
%elseif (n(2)~=0)
%    ortn=[0,-n(3),n(2)];
elseif (n(3)~=0)
    ortn=[-n(3),0,n(1)];
else
    disp('vettore nullo');
    return
end
ortn=ortn./norm(ortn,2);
p=[r*ortn(1);r*ortn(2);r*ortn(3);1];
nx=n(1);
ny=n(2);
nz=n(3);
c=cos(u);
s=sin(u);
R=[nx*nx*(1-c)+c,    nx*ny*(1-c)-nz*s, nx*nz*(1-c)+ny*s, A(1)*(1-v)+B(1)*v;...
   ny*nx*(1-c)+nz*s, ny*ny*(1-c)+c,    ny*nz*(1-c)-nx*s, A(2)*(1-v)+B(2)*v;...
   nz*nx*(1-c)-ny*s, nz*ny*(1-c)+nx*s, nz*nz*(1-c)+c,    A(3)*(1-v)+B(3)*v;...
   0, 0, 0, 1];
q=R*p;
x=q(1);
y=q(2);
z=q(3);

return
