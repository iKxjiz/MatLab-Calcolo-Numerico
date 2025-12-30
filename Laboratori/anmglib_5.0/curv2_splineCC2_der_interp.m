function spline=curv2_splineCC2_der_interp(Q,param,Qp)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv2_splineCC2_der_interp(Q,param,Qp)
%Calcola la spline cubica di interpolazione con derivate agli 
%estremi di una lista di punti 2D e restituisce la struttura 
%spline della curva
%Q           --> lista di punti da interpolare (npunti)x2
%param       --> scelta della parametrizzazione
%                -1=parametrizzazione delle ascisse dei punti Q
%                0=uniforme, 1=centripeta, 2=corda
%Qp          --> lista delle derivate negli estremi
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
    tt=X;
else
    tt = curv2_param(param,X,Y);
end

%calcolo delle derivate
if(nargin==3)
    if(param==-1)
        dy=Qp(:,1)';
    else
        dx=Qp(:,1)';
        dy=Qp(:,2)';
    end
else
    dx=scalar_derivatives(tt,X);
    dy=scalar_derivatives(tt,Y);
end

%calcolo della partizione nodale
t = partition_der(tt);

%calcolo dei coefficienti
[bs]=gc_bspl_valder(g,t,tt(2:n-1),0);
c =squeeze(bs(1,1:end,1:end));
% c=gc_bspl(g,t,tt(2:n-1));
if(param~=-1)
    px(1)=X(1);
    px(2)=1./3.*dx(1).*(tt(2)-tt(1))+X(1);
    px(n+1)=X(n)-1./3.*dx(length(dx)).*(tt(n)-tt(n-1));
    px(n+2)=X(n);
    X(2)=X(2)-px(2).*c(1,2);
    X(n-1)=X(n-1)-px(n+1).*c(n-2,n+1);
end
py(1)=Y(1);
py(2)=1./3.*dy(1).*(tt(2)-tt(1))+Y(1);
py(n+1)=Y(n)-1./3.*dy(length(dy)).*(tt(n)-tt(n-1));
py(n+2)=Y(n);
Y(2)=Y(2)-py(2).*c(1,2);
Y(n-1)=Y(n-1)-py(n+1).*c(n-2,n+1);
c=c(:,3:n);
py(3:n)=c\Y(2:n-1)';
if(param~=-1)
    px(3:n)=c\X(2:n-1)';
else
    px=greville(3,t);
end

spline.deg = g;
spline.cp(:,1)=px;
spline.cp(:,2)=py;
spline.knot = t;


