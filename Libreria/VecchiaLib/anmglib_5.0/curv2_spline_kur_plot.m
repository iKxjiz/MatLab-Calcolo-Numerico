function kur = curv2_spline_kur_plot(spline,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function kur = curv2_spline_kur_plot(spline,np,varargin)
%Disegna la funzione curvatura di una curva Spline 2D
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x2 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%np --> numero di punti per tratto in cui valutare e disegnare i valori di curvatura
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%kur <-- valori della funzione curvatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nm,mesh]=gc_mesh(spline.deg,spline.knot,abs(np));

Px=deboor_valder(spline,2,mesh);

for i=1:nm
kur(i) = (Px(2,i,1)*Px(3,i,2)-Px(2,i,2)*Px(3,i,1))/(sqrt (Px(2,i,1).^2+Px(2,i,2).^2).^3);
end

if (np > 0)
    mesh_curv2_plot(mesh,kur,varargin{:});
end

end

