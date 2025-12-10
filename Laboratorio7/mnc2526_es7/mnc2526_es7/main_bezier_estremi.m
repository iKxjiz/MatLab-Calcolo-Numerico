%Script main_bezier_estremi.m
%Questo script carica una curva di Bézier o
%Bézier a tratti e trova i suoi punti estremi
clear
close all
open_figure(1);
axis_plot(1,0.0625);

%carica curva
bezP=curv2_bezier_load('c2_bez_curv.db');

%numero punti di disegno
np=40;
%disegna curva
curv2_bezier_plot(bezP,np,'b-',2,'b');
%disegna poligonale di controllo
point_plot(bezP.cp,'r-o',1,'k','r',8);
[ncp,~]=size(bezP.cp);

%vettore dei valori parametrici dei punti estremi
extrema=[];

%struttura fBezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
%coefficienti della derivata prima della prima componente della curva
X = bezP.cp(:, 1);
% coefficienti di xprimo
f.cp = bezP.deg/(bezP.ab(2) - bezP.ab(1))*(X(2:end) - X(1:end-1));

% Determina gli zeri (valori parametrici) e valuta i punti estremi
TOL=1.0e-10;
rootsx = lane_riesenfeld(f,TOL);
if (length(rootsx) >= 1)
    fprintf('Lista delle radici di x trovate nell''intervallo della curva:\n');
    fprintf('%22.15e\n',rootsx);
    extrema=[extrema,rootsx];
    Px=decast_val(bezP,rootsx);
    plot(Px(:,1),Px(:,2),'ro');
end

%struttura fBezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
%coefficienti della derivata prima della seconda componente della curva
Y = bezP.cp(:, 2);
% coefficienti di xprimo
f.cp = bezP.deg/(bezP.ab(2) - bezP.ab(1))*(Y(2:end) - Y(1:end-1));

% Determina gli zeri (valori parametrici) e valuta i punti estremi
TOL=1.0e-10;
rootsy = lane_riesenfeld(f,TOL);
if (length(rootsy) >= 1)
    fprintf('Lista delle radici di y trovate nell''intervallo della curva:\n');
    fprintf('%22.15e\n',rootsy);
    extrema=[extrema,rootsy];
    Py=decast_val(bezP,rootsy);
    plot(Py(:,1),Py(:,2),'ro');
end


%% prova personale (fail)
%ext_sx = bezP.cp(1,:);
%ext_dx = bezP.cp(end, :);
%determina il bounding-box della curva
%[x, y] = rectangle_plot(ext_sx,Px,Py,ext_dx)
%%
extrema = [0, extrema, 1];
xy = decast_val(bezP, extrema);
minxy = min(xy);
maxxy = max(xy)
rectangle_plot(minxy(1), maxxy(1), minxy(2), maxxy(2), 'k', 2);

%disegna il bounding-box
