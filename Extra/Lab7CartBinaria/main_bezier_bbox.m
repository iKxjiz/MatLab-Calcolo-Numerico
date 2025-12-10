%Questo script carica una curva di Bézier o Bézier a tratti,
%trova i suoi punti estremi e determina il bounding-box
clear all
close all
open_figure(1);
axis_plot(1,0.125);

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
extrema=[0];
%struttura fBezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
%coefficienti della derivata prima della prima componente della curva
f.cp = (bezP.deg) * (bezP.cp(2:end,1) - bezP.cp(1:end-1,1));
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
%f.cp=...;
f.cp=(bezP.deg) * (bezP.cp(2:end,2) - bezP.cp(1:end-1,2));

TOL=1.0e-10;
rootsy = lane_riesenfeld(f,TOL);
if (length(rootsy) >= 1)
    fprintf('Lista delle radici di y trovate nell''intervallo della curva:\n');
    fprintf('%22.15e\n',rootsy);
    extrema=[extrema,rootsy];
    Py=decast_val(bezP,rootsy);
    plot(Py(:,1),Py(:,2),'go');
end

extrema=[extrema,1];

xy=decast_val(bezP,extrema);
%bounding-box = più piccolo rettangolo contenente i punti
%estremi ed il primo ed ultimo punto della curva
%definiamo il bounding-box come una curva di Bézier a tratti di grado 1

rect.ab = [0 1];
rect.cp =[
xy(1,1),Py(:,2);
Px(:,1),Py(:,2);
Px(:,1),xy(length(xy),2);
xy(1,1),xy(length(xy),2);
xy(1,1),Py(:,2);
];
rect.deg=length(rect.cp)-1;
%TO DO

area=curv2_ppbezier_area(rect);
fprintf('Area = %e \n',area)
point_plot(rect.cp,'k-',1.5);