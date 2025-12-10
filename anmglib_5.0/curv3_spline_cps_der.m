function cp = curv3_spline_cps_der(Q,t,tt,Qp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = curv3_spline_cps_der(Q,t,tt,Qp,g)
%Calcola la lista dei control point della curva spline cubica
%di interpolazione con derivate agli estremi da una lista di punti 3D
%Q      --> matrice dei punti (npuntix3)
%t      --> partizione nodale della curva
%tt     --> parametrizzazione della curva
%Qp     --> matrice delle derivate agli estremi
%cp     <-- lista dei control point (ncpsx3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = Q(:,1);
Y = Q(:,2);
Z = Q(:,3);
X=X';
Y=Y';
Z=Z';

n=length(X);

dx = Qp(:,1)';
dy = Qp(:,2)';
dz = Qp(:,3)';

px(1)=X(1);
px(2)=1./3.*dx(1).*(tt(2)-tt(1))+X(1);
px(n+1)=X(n)-1./3.*dx(length(dx)).*(tt(n)-tt(n-1));
px(n+2)=X(n);
py(1)=Y(1);
py(2)=1./3.*dy(1).*(tt(2)-tt(1))+Y(1);
py(n+1)=Y(n)-1./3.*dy(length(dy)).*(tt(n)-tt(n-1));
py(n+2)=Y(n);
pz(1)=Z(1);
pz(2)=1./3.*dz(1).*(tt(2)-tt(1))+Z(1);
pz(n+1)=Z(n)-1./3.*dz(length(dz)).*(tt(n)-tt(n-1));
pz(n+2)=Z(n);
if (n>1)
  c=gc_bspl(3,t,tt(2:n-1));
  X(2)=X(2)-px(2).*c(1,2);
  X(n-1)=X(n-1)-px(n+1).*c(n-2,n+1);
  Y(2)=Y(2)-py(2).*c(1,2);
  Y(n-1)=Y(n-1)-py(n+1).*c(n-2,n+1);
  Z(2)=Z(2)-pz(2).*c(1,2);
  Z(n-1)=Z(n-1)-pz(n+1).*c(n-2,n+1);
  c=c(:,3:n);
  px(3:n)=c\X(2:n-1)';
  py(3:n)=c\Y(2:n-1)';
  pz(3:n)=c\Z(2:n-1)';
end

cp(:,1) = px;
cp(:,2) = py;
cp(:,3) = pz;