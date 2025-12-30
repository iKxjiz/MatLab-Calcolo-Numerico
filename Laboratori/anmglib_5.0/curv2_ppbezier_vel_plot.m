function vel = curv2_ppbezier_vel_plot(ppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px = curv2_ppbezier_vel_plot(ppbez,np,varargin)
%Calcola e disegna la funzione velocità di una curva 2D Bézier a tratti
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> grado della curva o di ogni tratto
%          ppbez.cp  --> lista dei punti di controllo (nc*ppbez.deg+1) x 2
%          ppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np    --> numero di punti da plottare per tratto
%          se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel   <-- array con i valori della  funzione velocita'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%numero di tratti della curva
nc=length(ppbez.ab)-1;

i1=1;
vel=[];
for i=1:nc
  i2=i1+ppbez.deg;
  bezier.deg=ppbez.deg;
  bezier.cp=ppbez.cp(i1:i2,:);
  bezier.ab(1)=ppbez.ab(i);
  bezier.ab(2)=ppbez.ab(i+1);
  vel = [vel , curv2_bezier_vel_plot(bezier,np,varargin{:})];
  i1=i2;
end

end

