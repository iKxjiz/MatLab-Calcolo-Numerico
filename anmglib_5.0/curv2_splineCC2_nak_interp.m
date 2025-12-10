function spline=curv2_splineCC2_nak_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv2_splineCC2_nak_interp(Q,param)
%Calcola la spline cubica di interpolazione not-a-knot di una 
%lista di punti 2D e restituisce la struttura spline della curva
%Q           --> lista di punti da interpolare (npunti)x2
%param       --> scelta della parametrizzazione
%                -1=parametrizzazione delle ascisse dei punti Q
%                0=uniforme, 1=centripeta, 2=corda
%spline      <-- struttura della curva spline 2D
%       spline.deg  <-- grado della spline
%       spline.knot <-- partizione nodale estesa
%       spline.cp   <-- vettore dei control point
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = Q(:,1);
Y = Q(:,2);
X=X';
Y=Y';
n = length(X);


g = 3;

%calcolo della parametrizzazione
if(param==-1)
    tt = X;
else
    tt = curv2_param(param,X,Y);
end

%calcolo della partizione nodale
t = partition_nak(tt);


    
py(1)=Y(1);
py(n)=Y(n);
[bs]=gc_bspl_valder(3,t,tt(2:n-1),0);
c =squeeze(bs(1,1:end,1:end));
% c=gc_bspl(3,t,tt(2:n-1));
if(param~=-1)
    px(1)=X(1);
    px(n)=X(n);
    X(2)=X(2)-px(1).*c(1,1);
    X(n-1)=X(n-1)-px(n).*c(n-2,n);
end
Y(2)=Y(2)-py(1).*c(1,1);
Y(n-1)=Y(n-1)-py(n).*c(n-2,n);
c=c(:,2:n-1);
if(param~=-1)
    px(2:n-1)=c\X(2:n-1)';
else
    px=greville(3,t);
end
py(2:n-1)=c\Y(2:n-1)';

spline.deg = g;
spline.cp(:,1) = px;
spline.cp(:,2) = py;
spline.knot = t;

