function Px=ppbezier_val(ppP,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=ppbezier_val(ppP,x)
%Calcola il valore di una curva nD di bezier a tratti (ppP)
%definita dai punti di controllo ppP.cp nei punti x mediante 
%l'algoritmo di de Boor
%ppP --> struttura formata da 3 campi:
%          ppbezier.deg --> grado della curva
%          ppbezier.cp  --> lista dei punti di controllo
%          ppbezier.ab  --> partizione nodale
%x  --> lista dei punti in cui valutare
%Px <-- coordinate dei punti della curva nei punti x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%converte la curva ppP in una struttura spline a nodi multipli
%e utilizza la deboor_val per la valutazione
%conversione della ppP bezier a tratti in una struttura spline
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

Px=deboor_val(spl,x);
end

