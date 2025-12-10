function spline=curv2_splineCC2_per_interp(Q,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function spline=curv2_splineCC2_per_interp(Q,param)
%Calcola la spline Cubica C2 di interpolazione periodica di una lista 
%di punti 2D e restituisce la struttura della curva spline soluzione
%Q           --> lista di punti da interpolare (npunti)x2
%param       --> scelta della parametrizzazione
%                -1=parametrizzazione delle ascisse dei punti Q
%                 0=uniforme, 1=centripeta, 2=corda
%spline <-- struttura di una curva spline:
%          spline.deg <-- grado della curva
%          spline.cp  <-- lista dei punti di controllo (ncp)x2
%          spline.knot <-- vettore dei nodi (ncp+g+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = Q(:,1);
Y = Q(:,2);
X=X';
Y=Y';
n = length(X);

%grado della spline
g = 3;

%calcolo della parametrizzazione
if(param==-1)
    tt = X;
else
    tt = curv2_param(param,X,Y);
end

%calcolo della partizione nodale periodica
t = partition_per(tt);

%calcolo dei matrice dei coefficienti (B-spline nei punti di interp.)
[bs]=gc_bspl_valder(g,t,t(4:n+2),0);
c =squeeze(bs(1,1:end,1:end));
% c=gc_bspl(g,t,t(4:n+2));
c(1,n)=c(1,n)+c(1,1);
c(n-1,2)=c(n-1,2)+c(n-1,n+1);
c=c(:,2:n);
if (param==-1)
    px=greville(3,t);
else
    px(2:n)=c\X(1:n-1)';
    px(1)=px(n);
    px(n+1)=px(2);
    px(n+2)=px(3);
end
py(2:n)=c\Y(1:n-1)';
py(1)=py(n);
py(n+1)=py(2);
py(n+2)=py(3);

spline.deg = g;
spline.cp(:,1) = px;
spline.cp(:,2) = py;
spline.knot = t;


