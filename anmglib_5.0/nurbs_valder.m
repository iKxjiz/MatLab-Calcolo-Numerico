function Px=nurbs_valder(nurbs,kk,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=nurbs_valder(nurbs,kk,x)
%Calcola il valore nei punti x e le derivate fino a ordine kk<=g di una
%curva nD spline nella base B-spline definita dai punti di 
%controllo P mediante l'algoritmo di de Boor
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo 
%          nurbs.knot  --> vettore dei nodi
%kk --> ordine di derivazione (kk<=g)
%x  --> lista dei punti in cui valutare
%Px <-- punti della curva nurbs nei punti x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[n,nd]=size(nurbs.cp);

m=length(x);
Qx=zeros(m,nd+1);
Px=zeros(m,nd);
for i=1:n
  spline.cp(i,1:nd)=nurbs.cp(i,1:nd).*nurbs.w(i);
  spline.cp(i,nd+1)=nurbs.w(i);
end
spline.deg=nurbs.deg;
spline.knot=nurbs.knot;
Qx=deboor_valder(spline,kk,x);

%calcolo del valore
if (kk >= 0)
  for k=1:m
     Px(1,k,1:nd)=Qx(1,k,1:nd)./Qx(1,k,nd+1);
  end
end

%calcolo valore derivata prima
if (kk >= 1)
  for k=1:m
     Px(2,k,1:nd)=(Qx(2,k,1:nd)-Px(1,k,1:nd).*Qx(2,k,nd+1))./Qx(1,k,nd+1);
  end
end

%calcolo valore derivata seconda
if (kk >= 2)
  for k=1:m
     Px(3,k,1:nd)=(Qx(3,k,1:nd)-2.*Px(2,k,1:nd).*Qx(2,k,nd+1)-Px(1,k,1:nd).*Qx(3,k,nd+1))./Qx(1,k,nd+1);
  end
end

%calcolo valore derivata terza
if (kk >= 3)
  for k=1:m
     Px(4,k,1:nd)=(Qx(4,k,1:nd)-3.*Px(3,k,1:nd).*Qx(2,k,nd+1)-3.*Px(2,k,1:nd).*Qx(3,k,nd+1)-Px(1,k,1:nd).*Qx(3,k,nd+1))./Qx(1,k,nd+1);
  end
end

end

