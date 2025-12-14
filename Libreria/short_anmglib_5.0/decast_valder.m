function Px=decast_valder(bezier,k,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=decast_valder(bezier,k,t)
%Calcola il valore e le derivate fino a ordine k<=bezier.deg
%di una curva nD di Bezier in bezier.ab definita dai punti di controllo
%bezier.cp nei punti t mediante l'algoritmo di de Casteljau
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (g+1)x2
%          bezier.ab  --> intervallo di definizione
%k   --> ordine di derivazione; 0 valore, 1 derivata prima, ecc.
%t   --> lista dei punti in cui valutare
%Px  <-- valori e derivate della curva nei parametri t;
%        Px ha dimensione (k+1) x m x nD, dove m sono i parametri
%        in t ed nD e' la dimensione della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=length(bezier.cp(:,1));
if (k>n-1)
  k=n-1;
end
bezier.deg=n-1;
m=length(t);
%cambio di variabile [a,b]-->[0,1]
bma=bezier.ab(2)-bezier.ab(1);
t=(t-bezier.ab(1))./bma;

%algoritmo di de Casteljau
for ii=1:m
 V(1,:)=bezier.cp(1,:);
 W=bezier.cp;
 d1=t(ii);
 d2=1.0-t(ii);
 for j=1:bezier.deg
  for i=1:bezier.deg-j+1
   W(i,:)=d1.*W(i+1,:)+d2.*W(i,:);
  end
  V(j+1,:)=W(1,:);
 end
%nei vettori V e W ci sono i punti di controllo delle curve nella
%base di Bernstein in [0,tt(ii)] e [t(ii),1], allora
%p(t(ii)) =V(g+1)=W(1)
%p'(t(ii))=grado*(V(g+1)-V(g))/(d1*(b-a))=grado*(W(2)-W(1))/(d2*(b-a))
%ecc.
%valutazione derivate con opportuna scalatura
%d2 e d1 sono moltiplicati ad ogni passo per bma
%in quanto si deve tener conto che abbiamo inizialmente
%operato un cambio di variabile da [a,b]-->[0,1]
  if (d1<d2)
   d2=d2*bma;
   for j=1:k
    for i=k+1:-1:j+1
     W(i,:)=(bezier.deg+1-j)*(W(i,:)-W(i-1,:))./d2;
    end
   end
   for i=1:k+1
     Px(i,ii,:)=W(i,:);
   end
  else
   d1=d1*bma;
   for j=1:k
    for i=bezier.deg-k+1:bezier.deg-j+1
     V(i,:)=(bezier.deg+1-j).*(V(i+1,:)-V(i,:))./d1;
    end
   end
   for i=1:k+1
     Px(i,ii,:)=V(bezier.deg-i+2,:);
   end
  end
end

end
