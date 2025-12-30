function [bs,bs1,bs2]=gc_bpsspl(g,t,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bs,bs1,bs2]=gc_bpsspl(g,t,x)
%Valuta le funzioni base B-spline (non nulle) e le loro derivate
%prime e seconde in x; se x e' un vettore torna una matrice
%g   --> grado delle B-spline
%t   --> vettore dei knot
%x   --> lista dei punti in cui valutare
%bs  <-- matrice dei valori delle funzioni B-spline nei punti
%bs1 <-- matrice delle derivate prime delle funzioni B-spline nei punti
%bs2 <-- matrice delle derivate seconde delle funzioni B-spline nei punti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ll=gc_findint(g,t,x);
nt=length(t);
m=length(x);
n=nt-g-1;
bs=zeros(m,n);
bs1=zeros(m,n);
bs2=zeros(m,n);
for ii=1:m
% calcolo dell B-spline di grado g-1
  l=ll(ii);
  bs(ii,l)=1.0;
  k=l;
  for i=1:g-2
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
%applica passo per B-spline di grado g-1 e
%formula ricorrente derivata prima B-spline di grado g-1
  i=g-1;
  temp=0;
  temp1=0;
  for j=l:k
     d1=x(ii)-t(j);
     d2=t(i+j)-x(ii);
     beta=bs(ii,j)/(d1+d2);
     bs(ii,j-1)=d2*beta+temp;
     bs1(ii,j-1)=(g-1)*(temp1-beta);
     temp=d1*beta;
     temp1=beta;
  end
  bs(ii,k)=temp;
  bs1(ii,k)=(g-1)*temp1;
  l=l-1;
%applica passo per B-spline di grado g e
%formula ricorrente derivata prima B-spline di grado g
%formula ricorrente derivata seconda B-spline di grado g
  i=g;
  temp=0;
  temp1=0;
  temp2=0;
  for j=l:k
     d1=x(ii)-t(j);
     d2=t(i+j)-x(ii);
     beta=bs(ii,j)/(d1+d2);
     beta1=bs1(ii,j)/(d1+d2);
     bs(ii,j-1)=d2*beta+temp;
     bs1(ii,j-1)=g*(temp1-beta);
     bs2(ii,j-1)=g*(temp2-beta1);
     temp=d1*beta;
     temp1=beta;
     temp2=beta1;
  end
  bs(ii,k)=temp;
  bs1(ii,k)=g*temp1;
  bs2(ii,k)=g*temp2;
  l=l-1;
end

