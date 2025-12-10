function Px = curv2_ppbezier_tan_plot(ppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px = curv2_ppbezier_tan_plot(ppbez,np,varargin)
%Calcola i punti e i vettori tangenti di una curva 2D di Bézier a tratti;
%Disegna i vettori tangenti della curva 2D.
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> grado della curva o di ogni tratto
%          ppbez.cp  --> lista dei punti di controllo (nc*ppbez.deg+1) x 2
%          ppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np    --> numero di punti da plottare per tratto
%          se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px    <-- matrice (2 x np x 2D) con punti e vettori tangenti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%numero tratti della curva
nc=length(ppbez.ab)-1;

i1=1;
Px=[];
for i=1:nc
  i2=i1+ppbez.deg;
  bezier.deg=ppbez.deg;
  bezier.cp=ppbez.cp(i1:i2,:);
  bezier.ab(1)=ppbez.ab(i);
  bezier.ab(2)=ppbez.ab(i+1);
  Px = [Px , curv2_bezier_tan_plot(bezier,np,varargin{:})];
  i1=i2;
end

end

