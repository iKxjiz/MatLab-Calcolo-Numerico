function [x,y]= rectangle_trans_plot(xmin,xmax,ymin,ymax,M,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y]=rectangle_plot(xmin,xmax,ymin,ymax,varargin)
%Disegna sul piano cartesiano una rettangolo dati i suoi vertici estremi
%Se varargin non viene passato calcola solo i vertici del rettangolo senza disegnarlo
%xmin,ymin  --> vertice inferiore sinistro
%xmax,ymax  --> vertice superiore destro
%M  --> matrice 3x3 di trasformazione
%varargin --> argomenti opzionali di disegno da assegnare, in ordine: LineSpecification, LineWidth, 
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%x,y <-- vettori 1x5 contenenti le coordinate punti disegnati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%definisce vertici rettangolo
    p=[xmin,xmax,xmax,xmin,xmin;
       ymin,ymin,ymax,ymax,ymin;
       1,1,1,1,1];
%trasformazione dei punti
    q=M*p;
    x=q(1,:);
    y=q(2,:);
    if (nargin>5)
%disegna area rettangolare
       mesh_curv2_plot(x,y,varargin{:});
    end

return
