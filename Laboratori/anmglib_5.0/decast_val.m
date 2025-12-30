function Px=decast_val(bezier,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=decast_val(bezier,t)
%Calcola il valore di una curva nD nella base di Bernstein
%(curva di Bézier) nei punti t mediante l'algoritmo di de Casteljau
%bezier --> struttura di una curva di Bézier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo
%          bezier.ab  --> intervallo di definizione
%t  --> lista dei punti in cui valutare
%Px <-- punti della curva nei punti t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

m=length(t);
%cambio di variabile [a,b]-->[0,1]
bma=(bezier.ab(2)-bezier.ab(1));
t=(t-bezier.ab(1))./bma;

for ii=1:m
 W=bezier.cp;
 d1=t(ii);
 d2=1.0-t(ii);
 for j=1:bezier.deg
  for i=1:(bezier.deg-j+1)
    W(i,:)=d1.*W(i+1,:)+d2.*W(i,:);
  end
 end
 Px(ii,:)=W(1,:);
end
