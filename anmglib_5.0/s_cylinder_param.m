function [x,y,z]=s_cylinder_param(A,B,r,u,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=s_cylinder_param(A,B,r,u,v)
%Definizione parametrica della superficie cilindrica
%di asse definito dai punti 3D A e B con raggio di base r
%A,B   --> punti 3D che definiscono l'asse del tronco di cono
%r     --> raggio di base
%u,v   --> valori parametrici in [0,2*pi]x[0,1]
%x,y,z --> punto 3D della superficie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%cerchio di centro O, raggio r giacente sul piano
%con normale n per t in [0,2*pi]
n=B-A;
n=n./norm(n,2);
if (n(1)~=0 || n(2)~=0)
    ortn=[-n(2),n(1),0];
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
