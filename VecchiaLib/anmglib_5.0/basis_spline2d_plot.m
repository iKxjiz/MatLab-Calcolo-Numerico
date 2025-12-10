function basis_spline2d_plot(gu,u,gv,v)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_spline2d_plot(gu,u,gv,v)
%Valuta e disegna la base B-spline bivariata
%gu,gv  --> grado
%u  --> vettore dei knot in u
%v  --> vettore dei knot in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin == 0)
% basi di Bernstein bivariate
%*********************************************
% gu=2;
% gv=3;
% u=[zeros(1,gu+1) ones(1,gu+1)];
% v=[zeros(1,gv+1) ones(1,gv+1)];
%*********************************************

% basi B-spline Normalizzate bivariate
%*********************************************
gu=2;
gv=2;
h=3;
k=3;
u=[zeros(1,gu) linspace(0,1,h) ones(1,gu)];
v=[zeros(1,gv) linspace(0,1,k) ones(1,gv)];
%*********************************************

% basi B-spline Normalizzate bivariate con nodi doppi
%*********************************************
% gu=2;
% gv=3;
% h=2;
% k=3;
% nodi=[0 0.5 0.5 1];
% u=[zeros(1,gu) nodi ones(1,gu)];
% v=[zeros(1,gv) linspace(0,1,k) ones(1,gv)];
%*********************************************
end

nu=length(u);
nph=nu-gu-1;
nv=length(v);
mpk=nv-gv-1;
%griglia di valutazione uniforme su [a,b]
ni=11;
[nx,x]=gc_mesh(gu,u,ni);
ni=11;
[ny,y]=gc_mesh(gv,v,ni);

[X,Y]=meshgrid(x,y);
    
%figura con B-spline bivariate
%Valutazione B-spline
 [bs]=gc_bspl_valder(gu,u,x,0);
 zx =squeeze(bs(1,1:end,1:end));
%  zx=gc_bspl(gu,u,x);
 [bs]=gc_bspl_valder(gv,v,y,0);
 zy =squeeze(bs(1,1:end,1:end));
%  zy=gc_bspl(gv,v,y);
 figure;
 view(45,30);
 k=0;
 for i=1:nph
    for j=1:mpk
        k=k+1;
       subplot(nph,mpk,k);
       Z=zy(:,j)*zx(:,i)';
       %disegna funzione base (i,j)
       mesh(X,Y,Z);
    end
 end
%  figure;
%  view(45,30);
%  i=4; j=3;
%         Z=zy(:,j)*zx(:,i)';
%        %disegna funzione base (i,j)
%        mesh(X,Y,Z);
% 

end
