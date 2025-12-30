function [bsuv,X,Y]=gcw_bspl_2v(gu,gv,u,v,W,x,y)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bsuv,X,Y]=gcw_bspl_2v(gu,gv,u,v,W,x,y)
%Valuta le funzioni rational B-spline in un punto (x,y); se x ed y
%sono vettori torna la matrice bsuv 4D (dove bsuv(l,k,:,:) si riferisce
%al punto griglia di indici (l,k), mentre bsuv(:,:,i,j) si riferisce alla
%RB-spline di indici (i,j) e contiene i valori delle funzioni base 
%calcolate nei punti;
%gu --> grado in u della rational spline
%gv --> grado in v della rational spline
%u  --> vettore dei knot in u
%v  --> vettore dei knot in v
%W  --> matrice dei pesi
%x  --> lista dei punti di valutazione in x
%y  --> lista dei punti di valutazione in y
%bsuv <-- matrice 4D delle funzioni rational B-spline sulla griglia di punti
%         bsuv(:,:,i,j) rappresenta i valori della rational B-spline (i,j) su
%         tutti i punti della griglia di valutazione
%X  <-- matrici delle ascisse
%Y  <-- matrice delle ordinate
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nu=length(u);
nph=nu-gu-1;
nv=length(v);
mpk=nv-gv-1;

[X,Y]=meshgrid(x,y);
X=X';
Y=Y';
nx=length(x);
ny=length(y);
bsuv=zeros(nx,ny,nph,mpk);

%Valutazione RB-spline bivariate
zx=gc_bspl(gu,u,x);
zy=gc_bspl(gv,v,y);
sbs=zeros(nx,ny);
for i=1:nph
   for j=1:mpk
       bsuv(:,:,i,j)=W(i,j).*zx(:,i)*zy(:,j)';
       sbs=sbs+bsuv(:,:,i,j);
   end
end
 
for i=1:nph
   for j=1:mpk
       bsuv(:,:,i,j)=W(i,j).*zx(:,i)*zy(:,j)';
       bsuv(:,:,i,j)=bsuv(:,:,i,j)./sbs;
   end
end
