function Px = curv3_mdppbezier_plot(mdppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px = curv3_mdppbezier_plot(ppbez,np,varargin)
%Disegna una curva 3D Bezier a tratti
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> lista dei gradi della curva
%          ppbez.cp  --> lista dei punti di controllo ncpx3
%          ppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np    --> numero di punti da plottare per tratto
%          se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px    <-- punti di valutazione
%Nota: nc=length(ppbez.ab)-1
%      ncp = numero dei punti di controllo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% nc=length(ppbez.ab)-1;
% i1=1;
% Px=[];
% for i=1:nc
%   i2=i1+ppbez.deg(i);
%   Px = curv3_bezier_plot(ppbez.deg,ppbez.cp(i1:i2,:),ppbez.ab(i),ppbez.ab(i+1),np,varargin{:});
%   i1=i2;
% end

nc=length(mdppbez.ab)-1;
i1=1;
Px=[];
for i=1:nc
  i2=i1+mdppbez.deg(i);
  bezier.deg=mdppbez.deg(i);
  clear bezier.cp
  bezier.cp=mdppbez.cp(i1:i2,:);
  bezier.ab(1)=mdppbez.ab(i);
  bezier.ab(2)=mdppbez.ab(i+1);
  Px = curv3_bezier_plot(bezier,np,varargin{:});
  i1=i2;
end

end

