function spline=curv3_splineCC2_per_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv3_splineCC2_per_interp(Q,param)
%Calcola la spline cubica di interpolazione periodica di una 
%lista di punti 3D e restituisce la struttura spline della curva
%Q           --> lista di punti da interpolare (npunti)x3
%param       --> scelta della parametrizzazione
%                0=uniforme, 1=centripeta, 2=corda
%spline      <-- struttura della curva spline 3D
%       spline.deg  <-- grado della spline
%       spline.knot <-- partizione nodale estesa
%       spline.cp   <-- vettore dei control point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%calcolo della parametrizzazione
tt = curv3_param(Q,param);


%calcolo della partizione nodale
t = partition_per(tt);

%calcolo dei coefficienti
cp = curv3_spline_cps_per(Q,t);
% c=gc_bspl(g,t,t(4:n+2));
% c(1,n)=c(1,n)+c(1,1);
% c(n-1,2)=c(n-1,2)+c(n-1,n+1);
% c=c(:,2:n);
% px(2:n)=c\X(1:n-1)';
% px(1)=px(n);
% px(n+1)=px(2);
% px(n+2)=px(3);
% py(2:n)=c\Y(1:n-1)';
% py(1)=py(n);
% py(n+1)=py(2);
% py(n+2)=py(3);
% pz(2:n)=c\Z(1:n-1)';
% pz(1)=pz(n);
% pz(n+1)=pz(2);
% pz(n+2)=pz(3);

spline.deg = 3;
spline.cp(:,1) = cp(:,1);
spline.cp(:,2) = cp(:,2);
spline.cp(:,3) = cp(:,3);
spline.knot = t;


