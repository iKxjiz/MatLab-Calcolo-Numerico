function [x,y,z] = solid_cone_plot(A,B,rA,rB,nu,nv,type,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z] = solid_cone_plot(A,B,rA,rB,nu,nv,type,varargin)
%Disegna un solido elementare: tronco di cono
%si tratta di un tronco di cono definito dall'asse di estremi A e B
%e dai raggi rA ed rB;
%A,B --> punti 3D che definiscono l'asse del tronco di cono
%rA  --> raggio della base inferiore
%rB  --> raggio della base superiore
%nu,nv  --> numero punti griglia di valutazione per ogni faccia
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
%rappresentazione grafica di un solido elementare: cone
%si tratta di un cone definito dall'asse di estremi A e B e dai raggi rA ed rB;

u=linspace(0,2*pi,nu);
v=linspace(0,1,nv);
for i=1:nu
   for j=1:nv
        [x(i,j),y(i,j),z(i,j)]=s_cone_param(A,B,rA,rB,u(i),v(j));
    end
end

mesh_surf_plot(x,y,z,type,varargin{:});

n=B-A;
if (rA>0)
 for j=1:nv
   rr=rA*v(j);
   for i=1:nu
        [x(i,j),y(i,j),z(i,j)]=c3_circleXYZ(A,rr,n,u(i));
   end
 end
 
 mesh_surf_plot(x,y,z,type,varargin{:});
end

if (rB>0)
 for j=1:nv
   rr=rB*v(j);
   for i=1:nu
        [x(i,j),y(i,j),z(i,j)]=c3_circleXYZ(B,rr,n,u(i));
   end
 end
 
 mesh_surf_plot(x,y,z,type,varargin{:});
end

function [x,y,z]=s_cone_param(A,B,rA,rB,u,v)
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
pA=[rA*ortn(1);rA*ortn(2);rA*ortn(3);1];
pB=[rB*ortn(1);rB*ortn(2);rB*ortn(3);1];
p=[pA(1)*(1-v)+pB(1)*v;pA(2)*(1-v)+pB(2)*v;pA(3)*(1-v)+pB(3)*v;1];
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
