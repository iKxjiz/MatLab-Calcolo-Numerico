function kur=curv2_kur_plot(cs2name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function kur=curv2_kur_plot(cs2name,a,b,np,varargin)
%Disegna la funzione curvatura di una curva 2D in forma parametrica
%cs2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata seconda
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%kur <-- valori funzione curvatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cs2name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
  [x(i),y(i),xp(i),yp(i),xs(i),ys(i)]=curv(t(i));
  kur(i)=(xp(i)*ys(i)-yp(i)*xs(i))/sqrt(xp(i).^2+yp(i).^2).^3;
end

if (np > 0)
    %chiamata disegno funzione scalare
    mesh_curv2_plot(t,kur,varargin{:});
end

end

