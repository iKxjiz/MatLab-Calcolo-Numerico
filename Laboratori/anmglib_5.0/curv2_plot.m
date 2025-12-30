function [x,y]=curv2_plot(curvname,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y]=curv2_plot(curvname,a,b,np,varargin)
%Disegna una curva 2D in forma parametrica
%curvname --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo, valuta la curva, ma non disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%x,y <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(curvname);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i)]=curv(t(i));
end

if (np > 0)
    %chiamata di disegno
    mesh_curv2_plot(x,y,varargin{:});
end

end

