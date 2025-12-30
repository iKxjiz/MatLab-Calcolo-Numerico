function [npx,npy] = curv2_bezier_offset_plot(bezier,d,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [npx,npy] = curv2_bezier_offset_plot(bezier,np,varargin)
%Disegna l'offset di una curva 2D di Bezier
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%d   --> distanza (positiva o negativa) della curva offset dalla Bezier
%np  --> numero di punti di valutazione
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%npx,npy <-- coordinate dei punti offset/plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mesh = linspace(bezier.ab(1),bezier.ab(2),abs(np));

%Algoritmo1 da correggere
%bas_bernst = bernst_valder(bezier.deg,t);
%Px(:,1)=bas_bernst*bezier.cp(:,1);
%Px(:,2)=bas_bernst*bezier.cp(:,2);

%Algoritmo2
Px=decast_valder(bezier,1,mesh);

for i=1:abs(np)
  x(i)=Px(1,i,1);
  y(i)=Px(1,i,2);
  xp(i)=Px(2,i,1);
  yp(i)=Px(2,i,2);
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
% %colore e stile linea fissi a solid e ciano
%   plot([x(i),npx(i)],[y(i),npy(i)],'c-');
end

if (np > 0)
    %chiamata di disegno
    mesh_curv2_plot(npx,npy,varargin{:});
end

end

