function Px = curv2_mdppbezier_plot(mdppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function Px = curv2_mdppbezier_plot(mdppbez,np,varargin)
%Disegna una curva 2D di Bezier a tratti multi-degree
%mdppbez  --> struttura di una Bezier a tratti multi-degree:
%             mdppbez.deg --> lista dei gradi della curva
%             mdppbez.cp  --> lista dei punti di controllo ncp x 2
%             mdppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np       --> numero di punti da plottare per tratto
%             se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%Px       <-- punti della curva valutata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%numero di tratti della curva
nc=length(mdppbez.ab)-1;
%gradi
ng=length(mdppbez.deg);
if (ng==1 && nc>1)
%La curva non e' una mdppbezier, ma una ppbezier);
    mdppbez=curv2_ppbezier2mdppbezier(mdppbez);
end

i1=1;
Px=[];
for i=1:nc
  i2=i1+mdppbez.deg(i);
  bezier.deg=mdppbez.deg(i);
  bezier.cp=mdppbez.cp(i1:i2,:);
  bezier.ab(1)=mdppbez.ab(i);
  bezier.ab(2)=mdppbez.ab(i+1);
  Px = [Px ; curv2_bezier_plot(bezier,np,varargin{:})];
  i1=i2;
end

end

