function Px=curv3_spline_plot(spline,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv3_spline_plot(spline,np,varargin)
%Disegna una curva 3D spline
%spline --> struttura formata di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%np --> numero di punti da plottare per ciascun tratto
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px <-- punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[nm,mesh]=gc_mesh(spline.deg,spline.knot,abs(np));

%Algoritmo1
%bas_bspline = gc_bspl(spline.deg,spline.knot,mesh);
%x=bas_bspline*qx;
%y=bas_bspline*qy;
%z=bas_bspline*qz;

%Algoritmo2
Px=deboor_val(spline,mesh);

if (np > 0)
    %chiamata di disegno
    mesh_curv3_plot(Px(:,1),Px(:,2),Px(:,3),varargin{:});
end

end

