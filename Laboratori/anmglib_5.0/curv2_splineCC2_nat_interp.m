function spline=curv2_splineCC2_nat_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv2_splineCC2_nat_interp(Q,param)
%Calcola la spline cubica di interpolazione naturale di una 
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
t = partition_nat(tt);

%calcolo dei coefficienti
c=zeros(n);
[bs]=gc_bspl_valder(g,t,tt(2:n-1),0);
cc =squeeze(bs(1,1:end,1:end));
% cc=gc_bspl(g,t,tt(2:n-1));
c(2:n-1,:)=cc(:,2:n+1); 
c(1,1)=2*tt(1)-tt(2)-tt(3);
c(1,2)=tt(2)-tt(1);
c(1,3:n+1)=0;
c(n,n-1)=tt(n)-tt(n-1);
c(n,n)=tt(n-2)+tt(n-1)-2*tt(n);
if(param~=-1)
    px(1)=X(1);
    px(n+2)=X(n);
    X(1)=px(1)*(tt(1)-tt(3));
    X(n)=px(n+2)*(tt(n-2)-tt(n));
    q=c\X';
    px(2:n+1)=q(1:n);
else
    px=greville(3,t);
end

py(1)=Y(1);
py(n+2)=Y(n);
Y(1)=py(1)*(tt(1)-tt(3));
Y(n)=py(n+2)*(tt(n-2)-tt(n)); 
w=c\Y';
py(2:n+1)=w(1:n);

spline.deg = g;
spline.cp(:,1) = px;
spline.cp(:,2) = py;
spline.knot = t;


