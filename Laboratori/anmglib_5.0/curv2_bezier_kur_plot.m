function kur =curv2_bezier_kur_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function kur =curv2_bezier_kur_plot(bezier,np,varargin)
%Disegna la funzione curvatura di una curva 2D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti in cui valutare e disegnare i valori di curvatura
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%kur <-- valori della funzione curvatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% n=g+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

%Algoritmo2
Px=decast_valder(bezier,2,mesh);

for i=1:abs(np)
kur(i) = (Px(2,i,1)*Px(3,i,2)-Px(2,i,2)*Px(3,i,1))/(sqrt (Px(2,i,1).^2+Px(2,i,2).^2).^3);
end

if (np > 0)
    mesh_curv2_plot(mesh,kur,varargin{:});
end

end

