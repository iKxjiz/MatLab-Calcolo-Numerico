function vel = curv2_mdppbezier_vel_plot(mdppbez,np,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function vel = curv2_mdppbezier_vel_plot(mdppbez,np,varargin)
%Calcola e disegna la funzione velocità di una curva 2D Bézier
%a tratti multi-degree
%mdppbez  --> struttura di una Bezier a tratti multi-degree:
%             mdppbez.deg --> lista dei gradi della curva
%             mdppbez.cp  --> lista dei punti di controllo ncp x 2
%             mdppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%np       --> numero di punti da plottare per tratto
%             se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%vel     <-- array con i valori della  funzione velocita'
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
vel=[];
for i=1:nc
  i2=i1+mdppbez.deg(i);
  bezier.deg=mdppbez.deg(i);
  bezier.cp=mdppbez.cp(i1:i2,:);
  bezier.ab(1)=mdppbez.ab(i);
  bezier.ab(2)=mdppbez.ab(i+1);
  vel = [vel , curv2_bezier_vel_plot(bezier,np,varargin{:})];
  i1=i2;
end

end

