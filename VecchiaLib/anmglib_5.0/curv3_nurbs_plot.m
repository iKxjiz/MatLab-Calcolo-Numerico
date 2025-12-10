function Px=curv3_nurbs_plot(nurbs,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv3_nurbs_plot(nurbs,np,varargin)
%Disegna una curva 3D nurbs
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp x3)
%          nurbs.knot  --> vettore dei nodi (ncp+nurbs.deg+1)
%          nurbs.w --> lista dei pesi (ncp)
%np --> numero di punti da plottare per ciascun tratto
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px <-- punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%rappresentazione grafica di una curva di Bezier 2D
%non e' necessario prevedere [a,b] come input, infatti
%sara' per convenzione a=knot(g+1) e b=knot(end-g)

[nm,mesh]=gc_mesh(nurbs.deg,nurbs.knot,abs(np));

%Algoritmo1
%bas_brspline = gcw_bspl(g,knot,w,mesh);
%x=bas_brspline*qx;
%y=bas_brspline*qy;
%z=bas_brspline*qz;

%Algoritmo2
Px=nurbs_val(nurbs,mesh);

if (np > 0)
    %chiamata di disegno
    mesh_curv3_plot(Px(:,1),Px(:,2),Px(:,3),varargin{:});
end

end

