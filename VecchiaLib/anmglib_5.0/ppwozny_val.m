function Px=ppwozny_val(ppbez,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=ppwozny_val(ppbez,t)
%Calcola il valore di una curva nD nella base di Bernstein a tratti
%definita dai punti di controllo P nei punti t con l'algoritmo O(n)
%di Wozny e Chudy del 2020
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> grado della curva
%          ppbez.cp  --> lista dei punti di controllo ncp x 2
%          ppbez.ab  --> estremi dei tratti nc
%t  --> lista dei punti in cui valutare
%Px <-- punti della curva nei punti t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%indici relativi agli intervalli dei punti in cui valutare
l=gc_findinppab(ppbez.ab,t);
Px=[];
for j=1:length(l)
   k=l(j);
   i1=(k-1)*ppbez.deg+1;
   i2=i1+ppbez.deg;
   pp2bez.cp=ppbez.cp(i1:i2,:);
   pp2bez.deg=length(pp2bez.cp(:,1))-1;
   pp2bez.ab=[ppbez.ab(k) ppbez.ab(k+1)];
   Px(j,:)=wozny_val(pp2bez,t(j));
end
    
end
