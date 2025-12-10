function [bs,bs1]=gc_bpspl(g,t,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bs,bs1]=gc_bpspl(g,t,x)
%Valuta le funzioni base B-spline (non nulle) e le loro derivate
%prime in x; se x e' un vettore torna una matrice
%g   --> grado delle B-spline
%t   --> vettore dei knot
%x   --> lista dei punti in cui valutare
%bs  <-- matrice dei valori delle funzioni B-spline nei punti
%bs1 <-- matrice delle derivate prime delle funzioni B-spline nei punti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ll=gc_findint(g,t,x);
nt=length(t);
m=length(x);
n=nt-g-1;
bs=zeros(m,n);
bs1=zeros(m,n);
for ii=1:m
 l=ll(ii);
 bs(ii,l)=1.0;
 k=l;
 for i=1:g-1
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
 i=g;
 temp=0;
 temp1=0;
 for j=l:k
   d1=x(ii)-t(j);
   d2=t(i+j)-x(ii);
   beta=bs(ii,j)/(d1+d2);
   bs(ii,j-1)=d2*beta+temp;
   bs1(ii,j-1)=g*(temp1-beta);
   temp=d1*beta;
   temp1=beta;
 end
 bs(ii,k)=temp;
 bs1(ii,k)=g*temp1;
 l=l-1;
end

