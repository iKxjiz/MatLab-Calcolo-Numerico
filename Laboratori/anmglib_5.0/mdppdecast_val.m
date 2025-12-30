function Px=mdppdecast_val(mdppbez,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=mdppdecast_val(mdppbez,t)
%Calcola il valore di una curva nD di Bezier a tratti multi-degree
%definita dai punti di controllo P nei punti t 
%mdppbez --> struttura di una Bezier a tratti multi-degree:
%          mdppbez.deg --> lista dei gradi dei tratti della curva
%          mdppbez.cp  --> lista dei punti di controllo ncp x 2
%          mdppbez.ab  --> lista degli estremi dei tratti
%t  --> lista dei punti in cui valutare
%Px <-- punti della curva valutata in corrispondenza dei punti t
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Questa function esiste anche con il nome mdppbezier_val

%indici relativi agli intervalli dei punti in cui valutare
l=gc_findinppab(mdppbez.ab,t);
%indici dei CP per intervallo nodale
for j=1:length(mdppbez.ab)-1
      kk(j)=sum(mdppbez.deg(1:j-1)) + 1;
end
Px=[];
for j=1:length(l)
   k=l(j);
   i1=kk(k);
   i2=kk(k)+mdppbez.deg(k);
   bezier.deg = mdppbez.deg(k);
   bezier.cp = mdppbez.cp(i1:i2,:);
   bezier.ab(1) = mdppbez.ab(k);
   bezier.ab(2) = mdppbez.ab(k+1);
   Px(j,:) = decast_val(bezier,t(j));
end
    
end
