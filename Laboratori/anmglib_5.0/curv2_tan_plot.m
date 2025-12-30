function [xp,yp]=curv2_tan_plot(cp2name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [xp,yp]=curv2_tan_plot(cp2name,a,b,np,varargin)
%Disegna i vettori tangenti di una curva 2D in forma parametrica
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%xp,yp <-- coordinate dei vettori tangenti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cp2name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),xp(i),yp(i)]=curv(t(i));
end

% for i=1:abs(np)
%     td(i)=norm([xp(i),yp(i)],2);
%     tx(i)=xp(i)/td(i);
%     ty(i)=yp(i)/td(i);
% end

if (np > 0)
    for i=1:np
    %    plot([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],ls)
    %    plot([x(i),x(i)+xp(i)],[y(i),y(i)+yp(i)],ls)
         vect2_plot([x(i),y(i)],[xp(i),yp(i)],varargin{:});
    end
end

end

