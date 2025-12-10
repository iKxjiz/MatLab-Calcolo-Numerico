function kur = curv3_kur_plot(cs3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function kur = curv3_kur_plot(cs3name,a,b,np,varargin)
%Disegna la funzione curvatura di una curva 3D in forma parametrica
%cs3name --> nome del file con l'espressione parametrica
%            della curva fino alla derivata seconda
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%kur <-- valori della funzione curvatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cs3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i)]=curv(t(i));
 vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
 bd=norm(vect,2);
 kur(i)=bd/sqrt(xp(i).^2+yp(i).^2+zp(i).^2).^3;
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(t,kur,varargin{:});
end

end

