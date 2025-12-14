function [vecx,vecy]=curv2_offset_adapt_plot(cp2name,a,b,d,tol,varargin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [vecx,vecy]=curv2_offset_adapt_plot(cp2name,a,b,d,tol,varargin)
%Disegna la curva offset di una curva 2D in forma parametrica
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%a,b --> intervallo di definizione
%d   --> distanza (positiva o negativa) della curva offset dalla curva
%tol --> tolleranza di valutazione
%        se negativo si valuta, ma non si disegna
%varargin --> argomenti opzionali di disegno da assegnare nel seguente
%             ordine: LineSpecification, LineWidth,
%             MarkerEdgeColor, MarkerFaceColor, MarkerSize 
%vecx,vecy <-- coordinate dei punti offset sinistra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(cp2name);

tmin=a;
tmax=b;

[fx,fy,fpx,fpy]=curv(tmin);
vnT=norm([fpx,fpy],2);
vTx=fpx/vnT;
vTy=fpy/vnT;
vTortx=vTy;
vTorty=-vTx;
pin.x=fx+d*vTortx;
pin.y=fy+d*vTorty;
vecx(1)=fx+d*vTortx;
vecy(1)=fy+d*vTorty;

[fx,fy,fpx,fpy]=curv(tmax);
vnT=norm([fpx,fpy],2);
vTx=fpx/vnT;
vTy=fpy/vnT;
vTortx=vTy;
vTorty=-vTx;
pfin.x=fx+d*vTortx;
pfin.y=fy+d*vTorty;

tmed=tmin+(tmax-tmin)/2;
[fx,fy,fpx,fpy]=curv(tmed);
vnT=norm([fpx,fpy],2);
vTx=fpx/vnT;
vTy=fpy/vnT;
vTortx=vTy;
vTorty=-vTx;
pmed.x=fx+d*vTortx;
pmed.y=fy+d*vTorty;
[vecx,vecy]=c2_offset_rec_val(cp2name,tmin,pin,tmed,pmed,tmax,pfin,d,vecx,vecy,tol);

if (tol > 0)
    %chiamata di disegno
    mesh_curv2_plot(vecx,vecy,varargin{:});
end

end

