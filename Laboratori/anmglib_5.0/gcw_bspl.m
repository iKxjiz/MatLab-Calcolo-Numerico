function bs=gcw_bspl(g,t,w,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bs=gcw_bspl(g,t,w,x)
%Valuta le funzioni base rational B-spline (non nulle) in x;
%se x e' un vettore torna una matrice
%g  --> grado delle rational B-spline
%t  --> vettore dei knot
%w  --> lista dei pesi
%x  --> lista dei punti in cui valutare
%bs <-- matrice dei valori delle funzioni rational B-spline nei punti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bs=gc_bspl(g,t,x);
ll=gc_findint(g,t,x);
m=length(x);
for ii=1:m
 k=ll(ii);
 l=k-g;
 sbs=0.0;
 for j=l:k
     bs(ii,j)=w(j)*bs(ii,j);
     sbs=sbs+bs(ii,j);
 end
 for j=l:k
     bs(ii,j)=bs(ii,j)/sbs;
 end
end

