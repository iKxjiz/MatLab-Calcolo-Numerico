function Px=curv2_nurbs_plot(nurbs,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv2_nurbs_plot(nurbs,np,varargin)
%Disegna una curva 2D nurbs
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2
%          nurbs.knot  --> lista dei nodi
%          nurbs.w --> lista dei pesi (weight)
%np --> numero di punti da plottare per ciascun tratto
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%Px <-- punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[nm,mesh]=gc_mesh(nurbs.deg,nurbs.knot,abs(np));

%Algoritmo1
%bas_brspline = gcw_bspl(g,knot,qw,mesh);
%x=bas_brspline*qx;
%y=bas_brspline*qy;

%Algoritmo2
Px=nurbs_val(nurbs,mesh);

if (np > 0)
    %chiamata di disegno
    mesh_curv2_plot(Px(:,1),Px(:,2),varargin{:});
end

end

