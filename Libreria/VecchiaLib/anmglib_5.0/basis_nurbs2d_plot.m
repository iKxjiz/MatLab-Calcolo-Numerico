function basis_nurbs2d_plot(gu,u,gv,v,W)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_nurbs2d_plot(gu,u,gv,v,W)
%Valuta e disegna la base rational B-spline bivariata
%gu,gv  --> grado
%u      --> vettore dei knot in u
%v      --> vettore dei knot in v
%W      --> matrice dei pesi di dimensione ncpu x ncpv
%           ricorda: ncp=numero nodi - gu -1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (nargin==0)
gu=3;
gv=3;
u=[zeros(1,gu+1) ones(1,gu+1)];
v=[zeros(1,gv+1) ones(1,gv+1)];
W=ones(gu+1,gv+1);
W(1,1)=50;
W(1,4)=1;
%*********************************************

% basi B-spline Normalizzate bivariate come caso
% particolare di RB-spline
%*********************************************
% gu=2;
% gv=3;
% h=3;
% k=4;
% u=[zeros(1,gu) linspace(0,1,h) ones(1,gu)];
% wu=ones(1,2*(gu+1)+h);
% v=[zeros(1,gv) linspace(0,1,k) ones(1,gv)];
% wv=ones(1,2*(gv+1)+k);
% W=wu'*wv;
%*********************************************

% basi RB-spline Normalizzate bivariate
%*********************************************
% gu=2;
% gv=3;
% h=3;
% k=4;
% u=[zeros(1,gu) linspace(0,1,h) ones(1,gu)];
% wu=ones(1,2*(gu+1)+h);
% wu(4)=5;
% v=[zeros(1,gv) linspace(0,1,k) ones(1,gv)];
% wv=ones(1,2*(gv+1)+k);
% wv(6)=5;
% W=wu'*wv;
%*********************************************

% basi RB-spline Normalizzate bivariate con nodi doppi
%*********************************************
% gu=2;
% gv=3;
% h=2;
% k=3;
% nodi=[0 0.5 0.5 1];
% u=[zeros(1,gu) nodi ones(1,gu)];
% wu=ones(1,2*(gu+1)+h);
% wu(4)=5; wu(5)=5;
% v=[zeros(1,gv) linspace(0,1,k) ones(1,gv)];
% wv=ones(1,2*(gv+1)+k);
% wv(5)=5; wv(6)=5;
% W=wu'*wv;
%*********************************************
end

nu=length(u);
nph=nu-gu-1;
nv=length(v);
mpk=nv-gv-1;
%griglia di valutazione uniforme su [a,b]
ni=16;
[nx,x]=gc_mesh(gu,u,ni);
ni=11;
[ny,y]=gc_mesh(gv,v,ni);


 [bsuv,X,Y]=gcw_bspl_2v(gu,gv,u,v,W,x,y);
 figure;
 view(45,30);
 k=0;
 for i=1:nph
    for j=1:mpk
      k=k+1;
      subplot(nph,mpk,k);
      %disegna funzione base (i,j)
      mesh(X,Y,bsuv(:,:,i,j));
    end
 end
 
end
