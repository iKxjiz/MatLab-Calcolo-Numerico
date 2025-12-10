%Questo script carica una curva di Bézier o Bézier atratti,
%trova la curva aligned, trova i suoi punti estremi,
%il suo bounding-box, quindi il tight bounding-box
clear all
close all
open_figure(1);
axis_plot(1,0.125);

%carica curva
bezQ=curv2_bezier_load('c2_bez_curv.db');

%numero punti di disegno
np=40;
%disegna prima curva
curv2_bezier_plot(bezQ,np,'b-',2,'b');
%disegna poligonale di controllo
point_plot(bezQ.cp,'r-o',1,'k','r',8);
[ncp,~]=size(bezQ.cp);

%determina la curva aligned di una curva di Bézier
[bezP,T,R]=curve_align(bezQ);

%vettore dei valori estremi
extrema=[0];
%struttura fBezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
%coefficienti della derivata prima della prima componente della curva
%f.cp=...;
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
     plot(Py(:,1),Py(:,2),'ro');
end

extrema=[extrema,1];
xy=decast_val(bezP,extrema);
%bounding-box = più piccolo rettangolo contenente i punti
%estremi ed il primo ed ultimo punto della curva
%definisce il bounding-box come una curva di

%TO DO
rect.ab=bezP.ab;
rect.cp =[
    xy(1,:);
    xy(length(xy),:);
    xy(length(xy),1),Py(:,2);
    xy(1,1),Py(:,2);
    xy(1,:);
    ];
rect.deg=length(rect.cp)-1;





%trasformazione inversa e sua applicazione al bounding-box
 M=inv(R*T);
 tight=rect;
 tight.cp=point_trans_plot(rect.cp,M,'m',3);

 area=curv2_ppbezier_area(tight);
 fprintf('Area = %e \n',area)
 point_plot(rect.cp,'c-',1.5);

%function per determinare una curva aligned
function [bezQ,T,R]=curve_align(bezP)
  % Copia la struttura della curva di Bézier
   bezQ = bezP;
   
   % Primo punto di controllo
   C = bezP.cp(1,:);
   
   % Matrice di traslazione per portare il primo punto di controllo all'origine
   T = get_mat_trasl(-C);
   
   % Ultimo punto di controllo
   D = bezP.cp(end,:);
   
   % Punto traslato del controllo finale
   D_t = point_trans(D, T);
   
   % Calcolo dell'angolo di rotazione per portare l'ultimo punto sull'asse x positivo
   alfa = atan2(D_t(2), D_t(1));
   
   % Matrice di rotazione
   R = get_mat2_rot(-alfa); % Negativo per allineare correttamente
   
   % Combinazione delle trasformazioni: traslazione -> rotazione
   M = R * T; 
   
   % Applica la trasformazione ai punti di controllo
   bezQ.cp = point_trans(bezP.cp, M);
   
   % Disegna la curva trasformata
   curv2_ppbezier_plot(bezQ, 60, 'g');
   
   
end