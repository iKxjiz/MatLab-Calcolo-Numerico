function Px = curv3_ppbezier_plot(ppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px = curv3_ppbezier_plot(ppbez,np,varargin)
%Disegna una curva 3D Bezier a tratti
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> grado della curva o di ogni tratto
%          ppbez.cp  --> lista dei punti di controllo (nc*ppbez.deg+1) x 3
%          ppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np    --> numero di punti da plottare per tratto
%          se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px    <-- punti di valutazione
%Nota: nc=(ncp-1)/ppbez.deg, con ncp numero dei punti di controllo
%      o anche nc=length(ppbez.ab)-1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nc=length(ppbez.ab)-1;
%[ncp,m]=size(ppbez.cp);
%nc=(ncp-1)/ppbez.deg;
i1=1;
Px=[];
for i=1:nc
  i2=i1+ppbez.deg;
  bezier.deg=ppbez.deg;
  bezier.cp=ppbez.cp(i1:i2,:);
  bezier.ab(1)=ppbez.ab(i);
  bezier.ab(2)=ppbez.ab(i+1);
  Px = curv3_bezier_plot(bezier,np,varargin{:});
  i1=i2;
end

end

