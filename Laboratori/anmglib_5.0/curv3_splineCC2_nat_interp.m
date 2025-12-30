function spline=curv3_splineCC2_nat_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv3_splineCC2_nat_interp(Q,param)
%Calcola la spline cubica di interpolazione naturale di una 
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
t = partition_nat(tt);

%calcolo dei coefficienti
cp = curv3_spline_cps_nat(Q,t,tt);
% px(1)=X(1);
% px(n+2)=X(n);
% py(1)=Y(1);
% py(n+2)=Y(n);
% pz(1)=Z(1);
% pz(n+2)=Z(n);
% c=zeros(n);
% if (n>1)
%   cc=gc_bspl(g,t,tt(2:n-1));
%   c(2:n-1,:)=cc(:,2:n+1); 
%   c(1,1)=2*tt(1)-tt(2)-tt(3);
%   c(1,2)=tt(2)-tt(1);
%   c(1,3:n)=0;
%   c(n,n-1)=tt(n)-tt(n-1);
%   c(n,n)=tt(n-2)+tt(n-1)-2*tt(n);
%   X(1)=px(1)*(tt(1)-tt(3));
%   X(n)=px(n+2)*(tt(n-2)-tt(n));
%   Y(1)=py(1)*(tt(1)-tt(3));
%   Y(n)=py(n+2)*(tt(n-2)-tt(n));
%   Z(1)=pz(1)*(tt(1)-tt(3));
%   Z(n)=pz(n+2)*(tt(n-2)-tt(n));
% 
%   q=c\X';
%   px(2:n+1)=q(1:n);
%   
%   w=c\Y';
%   py(2:n+1)=w(1:n);
%   
%   e=c\Z';
%   pz(2:n+1)=e(1:n);
% end


spline.deg = 3;
spline.cp(:,1) = cp(:,1);
spline.cp(:,2) = cp(:,2);
spline.cp(:,3) = cp(:,3);
spline.knot = t;


