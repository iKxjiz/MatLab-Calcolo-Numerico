function Px=ppbezier_valder(ppP,k,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=ppbezier_valder(ppP,k,t)
%Calcola il valore e le derivate fino a ordine k<=ppP.deg
%di una curva nD di Bezier a tratti in ppP.ab definita dai punti 
%di controllo ppP.cp nei punti t mediante l'algoritmo di de deboor
%ppP --> struttura di una curva di Bezier a tratti:
%          ppP.deg --> grado della curva
%          ppP.cp  --> lista dei punti di controllo
%          ppP.ab  --> partizione nodale
%k   --> ordine di derivazione; 0 valore, 1 derivata prima, ecc.
%t   --> lista dei punti in cui valutare
%Px  <-- valori e derivate della curva nei parametri t;
%        Px ha dimensione (k+1) x m x nD, dove m sono i parametri
%        in t ed nD e' la dimensione della curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%converte la curva ppP in una struttura spline a nodi multipli
%e utilizza la deboor_val per la valutazione
%conversione della la ppP bezier a tratti in una struttura spline
spl.deg=ppP.deg;
spl.cp=ppP.cp;
m=length(ppP.ab);
spl.knot(1)=ppP.ab(1);
k1=1;
for i=1:m
    k2=k1+ppP.deg;
    spl.knot(k1+1:k2)=ppP.ab(i);
    k1=k2;
end
k1=k2+1;
spl.knot(k1)=ppP.ab(m);

Px=deboor_valder(spl,k,t);

end
