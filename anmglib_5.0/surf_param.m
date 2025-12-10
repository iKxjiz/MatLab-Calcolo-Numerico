function [pu,pv] = surf_param(param,npu,npv,x,y,z)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [pu,pv] = surf_param(param,npu,npv,x,y,z)
%Calcola la parametrizzazionedi una griglia di punti 3D  
%param  --> scelta della parametrizzazione
%           0=uniforme, 1=centripeta, 2=corda
%npu    --> numero di punti nella direzione u
%npv    --> numero di punti nella direzione v
%X      --> vettore delle ascisse
%Y      --> vettore delle ordinate
%Z      --> vettore delle quote
%pu     <-- parametrizzazione della griglia nella direzione u
%pv     <-- parametrizzazione della griglia nella direzione v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
alpha=0.5*param;

pu=zeros(1,npu);
for j=1:npv
  tau(1)=0;
  for i=2:npu
    tau(i)=tau(i-1)+(sqrt((x(i,j)-x(i-1,j)).^2+(y(i,j)-y(i-1,j)).^2+(z(i,j)-z(i-1,j)).^2)).^alpha;
  end
  for i=1:npu
    tt(i)=tau(i)/tau(npu);
  end
  pu=pu+tt;
end
pu=pu./npv;

clear tt;

pv=zeros(1,npv);
for i=1:npu
  tau(1)=0;
  for j=2:npv
    tau(j)=tau(j-1)+(sqrt((x(i,j)-x(i,j-1)).^2+(y(i,j)-y(i,j-1)).^2+(z(i,j)-z(i,j-1)).^2)).^alpha;
  end
  for j=1:npv
    tt(j)=tau(j)/tau(npv);
  end
  pv=pv+tt;
end
pv=pv./npu;