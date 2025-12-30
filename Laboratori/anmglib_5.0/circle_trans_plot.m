function [x,y,z] = circle_trans_plot(O,r,n,np,M,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z] = circle_trans_plot(O,r,n,np,M,varargin)
%Disegna sul piano definito dal punto 3D O e dal vettore
%normale n una circonferenza di centro O e raggio r dopo
%averla traformata con la matrice M
%O  --> punto 3D
%r  --> raggio
%n  --> vettore normale 3D
%np --> numero di punti del plot
%       se negativo si valuta, ma non si disegna
%M  --> matrice 4x4 di trasformazione
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%x,y,z <-- coordinate punti plottati
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

t = linspace(0,2*pi,abs(np));
for i=1:abs(np)
  c=cos(t(i));
  s=sin(t(i));
  R=[nx*nx*(1-c)+c,    nx*ny*(1-c)-nz*s, nx*nz*(1-c)+ny*s, O(1);...
     ny*nx*(1-c)+nz*s, ny*ny*(1-c)+c,    ny*nz*(1-c)-nx*s, O(2);...
     nz*nx*(1-c)-ny*s, nz*ny*(1-c)+nx*s, nz*nz*(1-c)+c,    O(3);...
     0, 0, 0, 1];
  q=M*R*p;
  x(i)=q(1);
  y(i)=q(2);
  z(i)=q(3);
end

if (np > 0)
  mesh_curv3_plot(x,y,z,varargin{:});
end

return
