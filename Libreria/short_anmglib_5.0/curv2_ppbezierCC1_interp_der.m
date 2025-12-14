function ppP=curv2_ppbezierCC1_interp_der(Q,Q1,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ppP=curv2_ppbezierCC1_interp_der(Q,Q1,t)
%Calcola la struttura Bezier cubica a tratti 2D di Hermite
%di interpolazione di una lista di punti 2D 
%Q     --> lista di punti da interpolare (npunti)x2
%Q1    --> lista vettori tangenti nei punti da interpolare (npunti)x2
%t     --> parametri in corrispondenza dei punti
%ppP   <-- struttura della curva 2D Bezier a tratti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cqx=Q(:,1);
cqy=Q(:,2);
dx=Q1(:,1);
dy=Q1(:,2);
m=length(cqx);
nc=m-1;
bma=t(m)-t(1);

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


