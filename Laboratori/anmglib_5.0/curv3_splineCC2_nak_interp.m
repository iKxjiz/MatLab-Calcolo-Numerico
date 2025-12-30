function spline=curv3_splineCC2_nak_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv3_splineCC2_nak_interp(Q,param)
%Calcola la spline cubica di interpolazione  not-a-knot di una 
%lista di punti 3D e restituisce la struttura spline della curva
%Q           --> lista di punti da interpolare (npunti)x3
%param       --> scelta della parametrizzazione
%                0=uniforme, 1=centripeta, 2=corda
%spline      <-- struttura della curva spline 3D
%       spline.deg  <-- grado della spline
%       spline.knot <-- partizione nodale estesa
%       spline.cp   <-- vettore dei control point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
g = 3;

%calcolo della parametrizzazione
tt = curv3_param(Q,param);


%calcolo della partizione nodale
t = partition_nak(tt);

%calcolo dei coefficienti
cp = curv3_spline_cps_nak(Q,t,tt);
% px(1)=X(1);
% px(n)=X(n);
% py(1)=Y(1);
% py(n)=Y(n);
% pz(1)=Z(1);
% pz(n)=Z(n);
% c=gc_bspl(g,t,tt(2:n-1));
% X(2)=X(2)-px(1).*c(1,1);
% X(n-1)=X(n-1)-px(n).*c(n-2,n);
% Y(2)=Y(2)-py(1).*c(1,1);
% Y(n-1)=Y(n-1)-py(n).*c(n-2,n);
% Z(2)=Z(2)-pz(1).*c(1,1);
% Z(n-1)=Z(n-1)-pz(n).*c(n-2,n);
% c=c(:,2:n-1);
% px(2:n-1)=c\X(2:n-1)';
% py(2:n-1)=c\Y(2:n-1)';
% pz(2:n-1)=c\Z(2:n-1)';


spline.deg = g;
spline.cp(:,1) = cp(:,1);
spline.cp(:,2) = cp(:,2);
spline.cp(:,3) = cp(:,3);
spline.knot = t;


