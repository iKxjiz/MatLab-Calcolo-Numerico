function [x,y,z]=c3_circleXYZ(O,r,n,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=c3_circleXYZ(O,r,n,t)
%Definizione parametrica della circonferenza 3D di centro 
%l'origine e raggio r sul piano definito dal punto O
%e dalla normale n
%O     --> punto 3D
%r     --> raggio della circonferenza
%n     --> normale che definisce il piano
%t     --> parametro in [0,2*pi]
%x,y,z --> punto 3D della circonferenza
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
c=cos(t);
s=sin(t);
R=[nx*nx*(1-c)+c,    nx*ny*(1-c)-nz*s, nx*nz*(1-c)+ny*s, O(1);...
   ny*nx*(1-c)+nz*s, ny*ny*(1-c)+c,    ny*nz*(1-c)-nx*s, O(2);...
   nz*nx*(1-c)-ny*s, nz*ny*(1-c)+nx*s, nz*nz*(1-c)+c,    O(3);...
   0, 0, 0, 1];
q=R*p;
x=q(1);
y=q(2);
z=q(3);

return
