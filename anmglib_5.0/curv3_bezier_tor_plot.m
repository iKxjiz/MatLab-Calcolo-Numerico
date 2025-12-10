function tor = curv3_bezier_tor_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function tau = curv3_bezier_tor_plot(bezier,np,varargin)
%Disegna la funzione torsione di una curva 3D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti in cui valutare e disegnare i valori di torsione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%tor <-- valori della funzione torsione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

n=bezier.deg+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

Px=decast_valder(bezier,3,mesh);

for i=1:abs(np)
 c1=[Px(2,i,1),Px(2,i,2),Px(2,i,3)];
 c2=[Px(3,i,1),Px(3,i,2),Px(3,i,3)];
 c3=[Px(4,i,1),Px(4,i,2),Px(4,i,3)];
 A=[c1',c2',c3'];
 tor(i)=det(A)/norm(cross(c1,c2),2)^2;
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(mesh,tor,varargin{:});
end

end