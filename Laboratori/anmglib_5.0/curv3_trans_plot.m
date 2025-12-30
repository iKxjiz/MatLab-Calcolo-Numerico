function [x,y,z]=curv3_trans_plot(curvname,a,b,np,M,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [x,y,z]=curv3_trans_plot(curvname,a,b,np,M,varargin)
%Disegna una curva 3D in forma parametrica dopo aver applicato la 
%trasformazione geometrica M 
%curvname --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%       se negativo si valuta, ma non si disegna
%M  --> matrice di trasformazione 4x4
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize
%x,y,z <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(curvname);
t = linspace(a,b,abs(np));
w(4)=1;
for i=1:abs(np)
 [w(1),w(2),w(3)]=curv(t(i));
 ww=M*w';
 x(i)=ww(1);
 y(i)=ww(2);
 z(i)=ww(3);
end

if (np > 0)
    %chiamata di disegno
    mesh_curv3_plot(x,y,z,varargin{:});
end

end

