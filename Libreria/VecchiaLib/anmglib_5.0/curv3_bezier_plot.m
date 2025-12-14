function Px=curv3_bezier_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px=curv3_bezier_plot(bezier,np,varargin)
%Disegna una curva 3D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px <-- punti di valutazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

%Algoritmo1
%bas_bernst = bernst_val(bezier.deg,mesh);
%x=bas_bernst*qx;
%y=bas_bernst*qy;
%z=bas_bernst*qz;

%Algoritmo2
Px=decast_val(bezier,mesh);

if (np > 0)
    %chiamata di disegno
    mesh_curv3_plot(Px(:,1),Px(:,2),Px(:,3),varargin{:});
end

end

