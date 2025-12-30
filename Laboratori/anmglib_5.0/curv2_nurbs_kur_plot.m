function kur = curv2_nurbs_kur_plot(nurbs,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function kur = curv2_nurbs_kur_plot(nurbs,np,varargin)
%Disegna la funzione curvatura di una curva nurbs 2D
%nurbs --> struttura di una curva nurbs:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2 
%          nurbs.w   --> lista dei pesi
%          nurbs.knot  --> vettore dei nodi (ncp+g+1)
%np --> numero di punti per tratto in cui valutare e disegnare i valori di curvatura
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%kur <-- valori della funzione curvatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nm,mesh]=gc_mesh(nurbs.deg,nurbs.knot,abs(np));

Px=nurbs_valder(nurbs,2,mesh);

for i=1:nm
kur(i) = (Px(2,i,1)*Px(3,i,2)-Px(2,i,2)*Px(3,i,1))/(sqrt (Px(2,i,1).^2+Px(2,i,2).^2).^3);
end

if (np > 0)
    mesh_curv2_plot(mesh,kur,varargin{:});
end

end

