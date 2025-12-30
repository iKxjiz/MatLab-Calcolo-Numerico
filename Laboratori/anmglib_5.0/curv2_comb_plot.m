function [npx,npy] = curv2_comb_plot(cs2name,a,b,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy] = curv2_comb_plot(cs2name,a,b,np,varargin)
%Disegna il comb di una curva 2D in forma parametrica
%cs2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata seconda
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%npx,npy <-- coordinate dei punti del comb e plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cs2name);
t = linspace(a,b,abs(np));
for i=1:abs(np)
 [x(i),y(i),xp(i),yp(i),xs(i),ys(i)]=curv(t(i));
end

% for i=1:abs(np)
%     td(i)=norm([xp(i),yp(i)],2);
%     tx(i)=xp(i)/td(i);
%     ty(i)=yp(i)/td(i);
% end
% for i=1:abs(np)
%     plot([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],'g-')
% end

for i=1:abs(np)
  k(i)=(xp(i)*ys(i)-yp(i)*xs(i))/sqrt(xp(i).^2+yp(i).^2).^3;
  nv=[-yp(i),xp(i)];
  normv=norm(nv,2);
  nv=nv./normv;
  npx(i)=x(i)-k(i)*nv(1);
  npy(i)=y(i)-k(i)*nv(2);
end

if (np > 0)
    for i=1:np
      %colore e stile linea fissi a solid e ciano
      plot([x(i),npx(i)],[y(i),npy(i)],'c-');
    end
    %chiamata di disegno
    mesh_curv2_plot(npx,npy,varargin{:});
end

end

