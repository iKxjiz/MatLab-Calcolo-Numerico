function [vecx,vecy]=curv2_adapt_plot(c2name,a,b,tol,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [vecx,vecy]=curv2_adapt_plot(c2name,a,b,tol,varargin)
%Disegna una curva 2D
%c2name --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione
%tol --> tolleranza di valutazione
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%vecx,vecy <-- coordinate dei punti plottati
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(c2name);

tmin=a;
tmax=b;

[fx,fy]=curv(tmin);
pin.x=fx;
pin.y=fy;
vecx(1)=fx;
vecy(1)=fy;

[fx,fy]=curv(tmax);
pfin.x=fx;
pfin.y=fy;

tmed=tmin+(tmax-tmin)/2;
[fx,fy]=curv(tmed);
pmed.x=fx;
pmed.y=fy;

[vecx,vecy]=c2_rec_val(c2name,tmin,pin,tmed,pmed,tmax,pfin,vecx,vecy,abs(tol));

if (tol > 0)
    %chiamata di disegno
    mesh_curv2_plot(vecx,vecy,varargin{:});
end

end

