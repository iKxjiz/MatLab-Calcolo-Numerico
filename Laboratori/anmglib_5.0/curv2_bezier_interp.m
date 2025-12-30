function bezier = curv2_bezier_interp(Q,a,b,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezier = curv2_bezier_interp(Q,a,b,param)
%Calcola la curva 2D di Bezier di interpolazione dei punti Q
%Q --> lista dei punti 2D di interpolazione (g+1)x2
%a,b --> intervallo di interpolazione
%param --> scelta della parametrizzazione
%           0=uniforme, 1=centripeta, 2=corda
%bezier <-- struttura della curva 2D di Bezier :
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo
%          bezier.ab  --> intervallo di definizione [a b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cqx=Q(:,1);
cqy=Q(:,2);
m=length(cqx);
n=m-1;
% bma=b-a;

%parametrizzazione
%alpha=0.0;  %uniforme
%alpha=0.5;  %centripeta
%alpha=1.0;  %corda
alpha=0.5*param;
%Calcola parametrizzazione
 tau(1)=0;
 for i=2:m
   tau(i)=tau(i-1)+sqrt((cqx(i)-cqx(i-1)).^2+(cqy(i)-cqy(i-1)).^2).^alpha;
 end
 t(1)=0;
 for i=2:m
   t(i)=tau(i)/tau(m);
 end
%fine parametrizzazione

%forma di Bernstein (Matrice delle funzioni base nei punti)
%tt=(t-a)./bma;
B=bernst_val(n,t);

%soluzione dei sistemi lineari
bezier.cp = zeros(m,2);
bezier.cp(:,1)=B\cqx;
bezier.cp(:,2)=B\cqy;

%definisco manualmente i campi della struttura bezier
bezier.deg = length(bezier.cp(:,1))-1;
bezier.ab = [a b];

end