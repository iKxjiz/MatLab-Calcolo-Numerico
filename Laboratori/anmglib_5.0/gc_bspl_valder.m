function [bs]=gc_bspl_valder(g,t,x,od)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bs]=gc_bspl_valder(g,t,x,od)
%Valuta le funzioni base B-spline (non nulle) e le loro derivate
%fino a ordine od<=g, in x.
%g   --> grado delle B-spline
%t   --> vettore dei knot
%x   --> lista dei punti in cui valutare
%od  --> ordine di derivazione; 0 valore, 1 valore e derivata, ecc.
%bs  <-- matrice a tre dimensioni dei valori e derivate delle funzioni 
%        B-spline nei punti; il primo indice e' l'ordine di derivazione,
%        il secondo e' l'indice del punto, il terzo e' l'indice della
%        funzione base B-spline
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ll=gc_findint(g,t,x);
if (nargin==3 | od<0)
  od=0;
end
m=length(x);
n=length(t)-g-1;
bs=zeros(od+1,m,n);
%ciclo sui punti di valutazione
for ii=1:m
  l=ll(ii);
  bs(1,ii,l)=1.0;
  k=l;
  beta=zeros(1,od);
%schema triangolare:
%ciclo sul grado
  for i=1:g
   temp=zeros(1,od+1);
   
 %ciclo sulle funzioni base di grado i; quelle di indici da l a k-1
   for j=l:k
     d1=x(ii)-t(j);
     d2=t(i+j)-x(ii);
     beta(1)=bs(1,ii,j)./(d1+d2);
     bs(1,ii,j-1)=d2.*beta(1)+temp(1);
 %calcolo delle funzioni B-spline derivate nei punti
     for kk=1:i+od-g
%          disp([i,j,kk])
       if(kk>1)
           beta(kk)=bs(kk,ii,j)/(d1+d2);
       end
       bs(kk+1,ii,j-1)=i*(temp(kk+1)-beta(kk));
       temp(kk+1)=beta(kk);
     end
     temp(1)=d1*beta(1);
   end
 %calcolo ultima funzione base di grado i; quelle di indice k
   bs(1,ii,k)=temp(1);
  %calcolo dell'ultima funzioni B-spline derivate nei punti; quella di
  %indice k
  for kk=1:i+od-g
      bs(kk+1,ii,k)=i*temp(kk+1);
  end
   
   l=l-1;
  end
end
