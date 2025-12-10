function ppP=curv3_ppbezierCC1_interp(Q,a,b,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppP=curv3_ppbezierCC1_interp(Q,a,b,param)
%Calcola la struttura Bezier cubica a tratti 3D di Hermite
%di interpolazione di una lista di punti 3D 
%Q     --> lista di punti da interpolare (npunti)x3
%a,b   --> intervallo di interpolazione
%param --> scelta della parametrizzazione
%          0=uniforma, 1=centripeta, 2=corda
%ls    --> line specification
%ppP   <-- struttura della curva di Bezier a tratti 3D
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cqx=Q(:,1);
cqy=Q(:,2);
cqz=Q(:,3);
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
   tau(i)=tau(i-1)+sqrt((cqx(i)-cqx(i-1)).^2+(cqy(i)-cqy(i-1)).^2+(cqz(i)-cqz(i-1)).^2).^alpha;
 end
 t(1)=a;
 for i=2:m
   t(i)=a+bma*tau(i)/tau(m);
 end
%fine parametrizzazione

%derivate stimate dai dati; 
dx=scalar_derivatives(t,cqx);
dy=scalar_derivatives(t,cqy);
dz=scalar_derivatives(t,cqz);

ht(1:m-1)=t(2:m)-t(1:m-1);
for i=1:nc
 trei=3*(i-1)+1;
 cpx(trei)=cqx(i);
 cpx(trei+1)=cqx(i)+dx(i).*ht(i)./3;
 cpx(trei+2)=cqx(i+1)-dx(i+1).*ht(i)./3;
 cpy(trei)=cqy(i);
 cpy(trei+1)=cqy(i)+dy(i).*ht(i)./3;
 cpy(trei+2)=cqy(i+1)-dy(i+1).*ht(i)./3;
 cpz(trei)=cqz(i);
 cpz(trei+1)=cqz(i)+dz(i).*ht(i)./3;
 cpz(trei+2)=cqz(i+1)-dz(i+1).*ht(i)./3;
end
cpx(trei+3)=cqx(m);
cpy(trei+3)=cqy(m);
cpz(trei+3)=cqz(m);

ppP.deg=3;
ppP.cp=zeros(3*nc+1,3);
ppP.cp(:,1)=cpx;
ppP.cp(:,2)=cpy;
ppP.cp(:,3)=cpz;
ppP.ab=zeros(1,m);
ppP.ab=t;

end


