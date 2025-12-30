function vel = curv3_vel_plot(cp3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv3_vel_plot(cp3name,a,b,np,varargin)
%Disegna la funzione velocita' di una curva 3D in forma parametrica
%cp3name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel <-- valori della funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cp3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i)]=curv(t(i));
 vel(i)=norm([xp(i),yp(i),zp(i)],2);
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(t,vel,varargin{:});
end

end

