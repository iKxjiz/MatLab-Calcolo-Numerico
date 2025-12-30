function [x,y,z]=curv3_plot(curvname,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=curv3_plot(curvname,a,b,np,varargin)
%Disegna una curva3D in forma parametrica
%curvname --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione
%np  --> numero di punti di valutazione
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%x,y,z <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(curvname);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i)]=curv(t(i));
end

if (np > 0)
    %chiamta di disegno
    mesh_curv3_plot(x,y,z,varargin{:});
end

end

