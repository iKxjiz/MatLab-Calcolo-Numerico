function cp = curv3_spline_cps_nak(Q,t,tt)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = curv3_spline_cps_nak(Q,t,tt)
%Calcola la lista dei control point della curva spline cubica
%di interpolazione Not a Knot da una lista di punti 3D
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
px(n)=X(n);
py(1)=Y(1);
py(n)=Y(n);
pz(1)=Z(1);
pz(n)=Z(n);
c=gc_bspl(3,t,tt(2:n-1));
X(2)=X(2)-px(1).*c(1,1);
X(n-1)=X(n-1)-px(n).*c(n-2,n);
Y(2)=Y(2)-py(1).*c(1,1);
Y(n-1)=Y(n-1)-py(n).*c(n-2,n);
Z(2)=Z(2)-pz(1).*c(1,1);
Z(n-1)=Z(n-1)-pz(n).*c(n-2,n);
c=c(:,2:n-1);
px(2:n-1)=c\X(2:n-1)';
py(2:n-1)=c\Y(2:n-1)';
pz(2:n-1)=c\Z(2:n-1)';


cp(:,1) = px;
cp(:,2) = py;
cp(:,3) = pz;