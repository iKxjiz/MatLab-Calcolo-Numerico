function [npx,npy] = curv2_offset_plot(cp2name,a,b,np,d,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy] = curv2_offset_plot(cs2name,a,b,np,varargin)
%Disegna il comb di una curva 2D in forma parametrica
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%d   --> distanza (positiva o negativa) della curva offset dalla curva
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%npx,npy <-- coordinate dei punti plottati
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
% for i=1:abs(np)
%     plot([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],'g-')
% end

for i=1:abs(np)
  nv=[-yp(i),xp(i)];
  normv=norm(nv,2);
  nv=nv./normv;
  npx(i)=x(i)-d*nv(1);
  npy(i)=y(i)-d*nv(2);
end

if (np > 0)
    %chiamata di disegno
    mesh_curv2_plot(npx,npy,varargin{:});
end

end

