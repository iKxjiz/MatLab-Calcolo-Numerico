function bezier = curv3_bezier_interp(Q,a,b,param)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bezier = curv3_bezier_interp(Q,a,b,param)
%Calcola la curva 3D di Bezier di interpolazione dei punti Q
%Q --> lista dei punti 3D di interpolazione (g+1)x3
%a,b --> intervallo di interpolazione
% param --> scelta della parametrizzazione
%           0=uniforma, 1=centripeta, 2=corda
%bezier <-- struttura della curva 3D di Bezier :
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione [a b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
cqx=Q(:,1);
cqy=Q(:,2);
cqz=Q(:,3);
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
   tau(i)=tau(i-1)+sqrt((cqx(i)-cqx(i-1)).^2+(cqy(i)-cqy(i-1)).^2+(cqz(i)-cqz(i-1)).^2).^alpha;
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
bezier.cp=zeros(m,3);
bezier.cp(:,1)=B\cqx;
bezier.cp(:,2)=B\cqy;
bezier.cp(:,3)=B\cqz;

%definisco manualmente i campi della struttura bezier
bezier.deg = length(bezier.cp(:,1,1))-1;
bezier.ab = [a b];


end




% function P=curv3_bezier_interp(Q,a,b,param)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %function P=curv3_bezier_interp(Q,a,b,param)
% %Calcola la curva 3D di Bezier di interpolazione dei punti Q
% %Q --> lista dei punti 3D di interpolazione (g+1)x3
% %a,b --> intervallo di interpolazione
% % param --> scelta della parametrizzazione
% %           0=uniforma, 1=centripeta, 2=corda
% %P <-- punti di controllo della curva 3D di Bezier (g+1)x3
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% cqx=Q(:,1);
% cqy=Q(:,2);
% cqz=Q(:,3);
% m=length(cqx);
% n=m-1;
% bma=b-a;
% 
% %parametrizzazione
% %alpha=0.0;  %uniforme
% %alpha=0.5;  %centripeta
% %alpha=1.0;  %corda
% alpha=0.5*param;
% %Calcola parametrizzazione
%  tau(1)=0;
%  for i=2:m
%    tau(i)=tau(i-1)+sqrt((cqx(i)-cqx(i-1)).^2+(cqy(i)-cqy(i-1)).^2+(cqz(i)-cqz(i-1)).^2).^alpha;
%  end
%  t(1)=0;
%  for i=2:m
%    t(i)=tau(i)/tau(m);
%  end
% %fine parametrizzazione
% 
% %forma di Bernstein (Matrice delle funzioni base nei punti)
% %tt=(t-a)./bma;
% B=bernst_val(n,t);
% 
% %soluzione dei sistemi lineari
% P=zeros(m,3);
% P(:,1)=B\cqx;
% P(:,2)=B\cqy;
% P(:,3)=B\cqz;
% 
% end
