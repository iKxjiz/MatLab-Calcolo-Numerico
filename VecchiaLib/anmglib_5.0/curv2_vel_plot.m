function vel = curv2_vel_plot(cp2name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_vel_plot(cp2name,a,b,np,varargin)
%Disegna la funzione velocita' di una curva 2D in forma parametrica
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel <-- valori della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cp2name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),xp(i),yp(i)]=curv(t(i));
 vel(i)=norm([xp(i),yp(i)],2);
end

if (np > 0)
    %chiamata di disegno
    mesh_curv2_plot(t,vel,varargin{:});
end

end

