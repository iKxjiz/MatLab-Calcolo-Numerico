function vel = curv3_bezier_vel_plot(bezier,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv3_bezier_vel_plot(bezier,np,varargin)
%Disegna la funzione velocita' di una curva di Bezier 3D
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%np --> numero di punti in cui valutare e disegnare i valori velocita'
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel <-- valori della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=bezier.deg+1;

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));


%Algoritmo2

Px=decast_valder(bezier,1,mesh);

for i=1:abs(np)
    vel(i)=norm([Px(2,i,1),Px(2,i,2),Px(2,i,3)],2);
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(mesh,vel,varargin{:});
end

end