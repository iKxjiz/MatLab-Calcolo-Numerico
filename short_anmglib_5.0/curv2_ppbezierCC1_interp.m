function ppP=curv2_ppbezierCC1_interp(Q,a,b,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppP=curv2_ppbezierCC1_interp(Q,a,b,param)
%Calcola la struttura Bezier cubica a tratti 2D di Hermite
%di interpolazione di una lista di punti 2D 
%Q     --> lista di punti da interpolare (npunti)x2
%a,b   --> intervallo di interpolazione
%param --> scelta della parametrizzazione
%          0=uniforme, 1=centripeta, 2=corda
%ppP   <-- struttura della curva di Bezier a tratti 2D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cqx=Q(:,1);
cqy=Q(:,2);
m=length(cqx);
nc=m-1;
bma=b-a;

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
 t(1)=a;
 for i=2:m
   t(i)=a+bma*tau(i)/tau(m);
 end
%fine parametrizzazione

%derivate stimate dai dati; 
dx=scalar_derivatives(t,cqx);
dy=scalar_derivatives(t,cqy);

ht(1:m-1)=t(2:m)-t(1:m-1);
for i=1:nc
 trei=3*(i-1)+1;
 cpx(trei)=cqx(i);
 cpx(trei+1)=cqx(i)+dx(i).*ht(i)./3;
 cpx(trei+2)=cqx(i+1)-dx(i+1).*ht(i)./3;
 cpy(trei)=cqy(i);
 cpy(trei+1)=cqy(i)+dy(i).*ht(i)./3;
 cpy(trei+2)=cqy(i+1)-dy(i+1).*ht(i)./3;
end
cpx(trei+3)=cqx(m);
cpy(trei+3)=cqy(m);

ppP.deg=3;
ppP.cp=zeros(3*nc+1,2);
ppP.cp(:,1)=cpx;
ppP.cp(:,2)=cpy;
ppP.ab=zeros(1,m);
ppP.ab=t;

end


