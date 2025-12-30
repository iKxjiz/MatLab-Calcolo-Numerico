function bs=gc_bspl(g,t,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bs=gc_bspl(g,t,x)
%Valuta le funzioni base B-spline (non nulle) in x;
%se x e' un vettore torna una matrice
%g  --> grado delle B-spline
%t  --> vettore dei knot
%x  --> lista dei punti in cui valutare
%bs <-- matrice dei valori delle funzioni B-spline nei punti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ll=gc_findint(g,t,x);
nt=length(t);
m=length(x);
n=nt-g-1;
bs=zeros(m,n);
for ii=1:m
 l=ll(ii);
 bs(ii,l)=1.0;
 k=l;
 for i=1:g
   temp=0.0;
   for j=l:k
     d1=x(ii)-t(j);
     d2=t(i+j)-x(ii);
     beta=bs(ii,j)./(d1+d2);
     bs(ii,j-1)=d2.*beta+temp;
     temp=d1.*beta;
   end
   bs(ii,k)=temp;
   l=l-1;
  end
end

