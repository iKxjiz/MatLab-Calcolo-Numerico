function [x,y]= rectangle_plot(xmin,xmax,ymin,ymax,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y]=rectangle_plot(xmin,xmax,ymin,ymax,varargin)
%Disegna sul piano cartesiano una rettangolo dati i suoi vertici estremi
%xmin,ymin  --> vertice inferiore sinistro
%xmax,ymax  --> vertice superiore destro
%Se varargin non viene passato calcola solo i vertici del rettangolo senza disegnare
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%x,y <-- vettori 1x5 contenenti le coordinate punti disegnati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%definisce vertici rettangolo
    x=[xmin,xmax,xmax,xmin,xmin];
    y=[ymin,ymin,ymax,ymax,ymin];
    if nargin>4
%disegna area rettangolare
       mesh_curv2_plot(x,y,varargin{:});
    end

return
