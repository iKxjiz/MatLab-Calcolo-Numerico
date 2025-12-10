function cp = curv3_spline_cps_per(Q,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function t = curv3_spline_cps_per(Q,t)
%Calcola la lista dei control point della curva spline cubica
%di interpolazione periodica da una lista di punti 3D
%Q      --> matrice dei punti (npuntix3)
%t      --> partizione nodale della curva
%cp     <-- matrice dei control point (ncpsx3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

X = Q(:,1);
Y = Q(:,2);
Z = Q(:,3);
X=X';
Y=Y';
Z=Z';

n=length(X);

c=gc_bspl(3,t,t(4:n+2));
c(1,n)=c(1,n)+c(1,1);
c(n-1,2)=c(n-1,2)+c(n-1,n+1);
c=c(:,2:n);
px(2:n)=c\X(1:n-1)';
px(1)=px(n);
px(n+1)=px(2);
px(n+2)=px(3);
py(2:n)=c\Y(1:n-1)';
py(1)=py(n);
py(n+1)=py(2);
py(n+2)=py(3);
pz(2:n)=c\Z(1:n-1)';
pz(1)=pz(n);
pz(n+1)=pz(2);
pz(n+2)=pz(3);

cp(:,1) = px;
cp(:,2) = py;
cp(:,3) = pz;