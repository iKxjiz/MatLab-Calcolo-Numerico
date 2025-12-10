function Px=nurbs_val(nurbs,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=nurbs_val(nurbs,x)
%Calcola il valore nei punti x di una curva nD nurbs nella base B-spline
%definita dai punti di controllo nurbs.cp mediante
%l'algoritmo di de Boor
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo
%          nurbs.knot  --> vettore dei nodi
%          nurbs.w --> lista dei pesi (weight)
%x  --> lista dei punti in cui valutare
%Px <-- coordinate dei punti della curva nurbs nei punti x
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
Qx=deboor_val(spline,x);
for k=1:m
    Px(k,1:nd)=Qx(k,1:nd)./Qx(k,nd+1);
end

end

