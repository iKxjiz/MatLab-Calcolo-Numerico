%Questo programma carica due curva di Bézier e determina le intersezioni
%le curve possono essere anche ppBézier o altro (vedi curv2_intersect del
%toolbox anmglib_4.0
clear all
close all
open_figure(1);
axis_plot(1,0.125);

%carica prima curva
% bez1=curv2_bezier_load('c2_bezier1.db');
bez1=curv2_bezier_load('c2_bezA.db');
%carica seconda curva
% bez2=curv2_bezier_load('c2_bezier2.db');
bez2=curv2_bezier_load('c2_bezB.db');

%numero punti di disegno
np=20;

%disegna prima curva
curv2_bezier_plot(bez1,np,'b-',2,'b');
%disegna poligonale di controllo
point_plot(bez1.cp(1,:),'bo',1,'b','b',8);

%disegna seconda curva
curv2_bezier_plot(bez2,np,'r-',2,'r');
%disegna poligonale di controllo
point_plot(bez2.cp(1,:),'ro',1,'r','r',8);

%chiamata alla function curv2_intersect
[IP1P2,t1,t2]=curv2_intersect(bez1,bez2);
%disegno e stampa dei punti di intersezione
point_plot(IP1P2','r');

%suddividiamo la prima curva conservando la parte centrale
%TO DO
[p1_sx,p1_dx]=ppbezier_subdiv(bez1,t1(1));
% curv2_bezier_plot(p1_sx,np,'r-',2,'r');
%  curv2_bezier_plot(p1_dx,np,'g-',2,'g');
[p1_1_sx,p1_1_dx]=ppbezier_subdiv(p1_dx,t1(2));
curv2_bezier_plot(p1_1_sx,np,'c-',2,'c');
curv2_bezier_plot(p1_1_dx,np,'m-',2,'m');


%suddividiamo la seconda curva conservando la parte centrale
%TO DO
[p2_sx,p2_dx]=ppbezier_subdiv(bez2,t2(1));
% curv2_bezier_plot(p2_sx,np,'b-',2,'b');
% curv2_bezier_plot(p2_dx,np,'m-',2,'m');
[p2_2_sx,p2_2_dx]=ppbezier_subdiv(p2_dx,t2(2));
% curv2_bezier_plot(p2_2_sx,np,'b-',2,'b');
% curv2_bezier_plot(p2_2_dx,np,'m-',2,'m');

%uniamo le due parti centrali per dar luogo ad una curva chiusa
%la curv2_ppbezier_join funziona anche se le curve di input sono
%solo curve di Bézier
tol=1.0e-2;
%TO DO
ppQ=curv2_ppbezier_join(p1_1_sx,p2_2_sx,tol);

open_figure(2);
axis_plot(1,0.125);
Px=curv2_ppbezier_plot(ppQ,-np,'r-',2,'r');
point_fill(Px,'g','k-',1.5);


