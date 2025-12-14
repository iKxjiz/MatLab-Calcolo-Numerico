function cp = curv3_spline_cps_nat(Q,t,tt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = curv3_spline_cps_nat(Q,t,tt)
%Calcola la lista dei control point della curva spline cubica
%di interpolazione naturale da una lista di punti 3D
%Q      --> matrice dei punti (npuntix3)
%t      --> partizione nodale della curva
%tt     --> parametrizzazione della curva
%cp     <-- matrice dei control point (ncpsx3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = Q(:,1);
Y = Q(:,2);
Z = Q(:,3);
X=X';
Y=Y';
Z=Z';

n=length(X);

px(1)=X(1);
px(n+2)=X(n);
py(1)=Y(1);
py(n+2)=Y(n);
pz(1)=Z(1);
pz(n+2)=Z(n);
c=zeros(n);
if (n>1)
  cc=gc_bspl(3,t,tt(2:n-1));
  c(2:n-1,:)=cc(:,2:n+1); 
  c(1,1)=2*tt(1)-tt(2)-tt(3);
  c(1,2)=tt(2)-tt(1);
  c(1,3:n)=0;
  c(n,n-1)=tt(n)-tt(n-1);
  c(n,n)=tt(n-2)+tt(n-1)-2*tt(n);
  X(1)=px(1)*(tt(1)-tt(3));
  X(n)=px(n+2)*(tt(n-2)-tt(n));
  Y(1)=py(1)*(tt(1)-tt(3));
  Y(n)=py(n+2)*(tt(n-2)-tt(n));
  Z(1)=pz(1)*(tt(1)-tt(3));
  Z(n)=pz(n+2)*(tt(n-2)-tt(n));

  q=c\X';
  px(2:n+1)=q(1:n);
  
  w=c\Y';
  py(2:n+1)=w(1:n);
  
  e=c\Z';
  pz(2:n+1)=e(1:n);
end

cp(:,1) = px;
cp(:,2) = py;
cp(:,3) = pz;