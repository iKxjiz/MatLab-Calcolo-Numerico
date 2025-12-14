function spline=curv3_splineCC2_der_interp(Q,param,Qp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv3_splineCC2_der_interp(Q,param,Qp)
%Calcola la spline cubica di interpolazione con derivate agli estremi 
%di una lista di punti 3D e restituisce la struttura spline della curva
%Q           --> lista di punti da interpolare (npunti)x3
%param       --> scelta della parametrizzazione
%                0=uniforme, 1=centripeta, 2=corda
%Qp          --> derivate agli estremi 
%spline      <-- struttura della curva spline 3D
%       spline.deg  <-- grado della spline
%       spline.knot <-- partizione nodale estesa
%       spline.cp   <-- vettore dei control point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = Q(:,1);
Y = Q(:,2);
Z = Q(:,3);
X=X';
Y=Y';
Z=Z';

%calcolo della parametrizzazione
tt = curv3_param(Q,param);

%calcolo delle derivate
if(nargin==3)
    dx=Qp(:,1)';
    dy=Qp(:,2)';
    dz=Qp(:,3)';
else
    dx=scalar_derivatives(tt,X);
    dy=scalar_derivatives(tt,Y);
    dz=scalar_derivatives(tt,Z);
end

%calcolo della partizione nodale
t = partition_der(tt);

%calcolo dei coefficienti
D(:,1)=dx;
D(:,2)=dy;
D(:,3)=dz;

cp = curv3_spline_cps_der(Q,t,tt,D);
% px(1)=X(1);
% px(2)=1./3.*dx(1).*(tt(2)-tt(1))+X(1);
% px(n+1)=X(n)-1./3.*dx(length(dx)).*(tt(n)-tt(n-1));
% px(n+2)=X(n);
% py(1)=Y(1);
% py(2)=1./3.*dy(1).*(tt(2)-tt(1))+Y(1);
% py(n+1)=Y(n)-1./3.*dy(length(dy)).*(tt(n)-tt(n-1));
% py(n+2)=Y(n);
% pz(1)=Z(1);
% pz(2)=1./3.*dz(1).*(tt(2)-tt(1))+Z(1);
% pz(n+1)=Z(n)-1./3.*dz(length(dz)).*(tt(n)-tt(n-1));
% pz(n+2)=Z(n);
% if (n>1)
%   c=gc_bspl(g,t,tt(2:n-1));
%   X(2)=X(2)-px(2).*c(1,2);
%   X(n-1)=X(n-1)-px(n+1).*c(n-2,n+1);
%   Y(2)=Y(2)-py(2).*c(1,2);
%   Y(n-1)=Y(n-1)-py(n+1).*c(n-2,n+1);
%   Z(2)=Z(2)-pz(2).*c(1,2);
%   Z(n-1)=Z(n-1)-pz(n+1).*c(n-2,n+1);
%   c=c(:,3:n);
%   px(3:n)=c\X(2:n-1)';
%   py(3:n)=c\Y(2:n-1)';
%   pz(3:n)=c\Z(2:n-1)';
% end

spline.deg = 3;
spline.cp(:,1) = cp(:,1);
spline.cp(:,2) = cp(:,2);
spline.cp(:,3) = cp(:,3);
spline.knot = t;


