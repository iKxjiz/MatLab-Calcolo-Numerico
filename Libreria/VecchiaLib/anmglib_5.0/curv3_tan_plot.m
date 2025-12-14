function [xp,yp,zp]=curv3_tan_plot(cp3name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xp,yp,zp]=curv3_tan_plot(cp3name,a,b,np,varargin)
%Disegna i vettori tangente di una curva 3D in forma parametrica
%cp3name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%xp,yp,zp <-- coordinate dei vettori tangenti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cp3name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),z(i),xp(i),yp(i),zp(i)]=curv(t(i));
end

%for i=1:abs(np)
%    td(i)=norm([xp(i),yp(i),zp(i)],2);
%    tx(i)=xp(i)/td(i);
%    ty(i)=yp(i)/td(i);
%    tz(i)=zp(i)/td(i);
%end

if (np > 0)
    for i=1:np
    %    plot3([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],[z(i),z(i)+tz(i)],ls)
        vect3_plot([x(i),y(i),z(i)],[xp(i),yp(i),zp(i)],varargin{:});
    end
end

end

