function tau = curv3_tor_plot(ct3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function tau = curv3_tor_plot(ct3name,a,b,np,varargin)
%Disegna la funzione torsione di una curva 3D in forma parametrica
%ct3name --> nome del file con l'espressione parametrica
%            della curva fino alla derivata terza
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%tau <-- valori della funzione torsione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(ct3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i),xt(i),yt(i),zt(i)]=curv(t(i));
 vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
 bd=norm(vect,2);
 A=[xp(i),yp(i),zp(i);xs(i),ys(i),zs(i);xt(i),yt(i),zt(i)];
 tau(i)=det(A)/bd^2;
end

if (np > 0)
    %chiamata di disegno per funzione scalare
    mesh_curv2_plot(t,tau,varargin{:});
end

end

