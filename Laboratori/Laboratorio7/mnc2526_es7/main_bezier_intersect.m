%Script main_bezier_intersect.m
%Questo script carica due curve di Bézier e determina le intersezioni;
%le curve possono essere anche a tratti
clear
close all
clc
open_figure(1);
axis_plot(1,0.0625);

%% 1-
% carica prima curva
bez1=curv2_bezier_load('c2_bezA.db');
%bez1=curv2_bezier_reverse(bez1); (DOMANDA, perchè reverse?)

% carica seconda curva
bez2=curv2_bezier_load('c2_bezB.db');
%bez2=curv2_bezier_reverse(bez2);

%numero punti di disegno
np=40;

%disegna prima curva
curv2_bezier_plot(bez1,np,'b-',2,'b');

%disegna primo punto della prima curva
point_plot(bez1.cp(1,:),'bo',1,'b','b',8);

%disegna seconda curva
curv2_bezier_plot(bez2,np,'r-',2,'r');
%disegna primo punto della seconda curva
point_plot(bez2.cp(1,:),'ro',1,'r','r',8);

%% 2-
%interseca le due curve
[IP1P2, t1, t2] = curv2_intersect(bez1,bez2);
if (length(t1)>0)
    % Visualizza i punti di intersezione trovati
    point_plot(IP1P2','go',1,'g','g',8);
    % Stampa informazioni sulle intersezioni
    fprintf('IP1P2 = %e %e\n',IP1P2);
    fprintf('t1 = %e\n',t1);
    fprintf('t2 = %e\n',t2);
end

% Breve aggiunta / nota personale :
%val1_bez1_prima_interz = decast_val(bez1, t1(1))
%val1_bez1_seconda_interz = decast_val(bez1, t1(2))
%val2_bez2_prima_interz = decast_val(bez2, t2(1))
%val2_bez2_seconda_interz = decast_val(bez2, t2(2))
%IP1P2 % sono i punti di intersezione delle due curve

% qunado facciamo curv2_bezier_intersect(bez1, bez2), ritornano i
% i parametri "t", tali per cui, se valutati con l'algoritmo di
% De Castel Jo, ritornano le coordinate dei punti di intersezione.

%% 3-
%suddivide la prima curva nei due punti di intersezione
%per ottenere il tratto centrale
[p1_sx,p1]=decast_subdiv(bez1,t1(1));
%curv2_bezier_plot(p1_sx,np,'b-',2,'b');
%curv2_bezier_plot(p1,np,'b-',2,'b');
[p1,p1_1_dx]=decast_subdiv(p1,t1(2));
%curv2_bezier_plot(p1,np,'b-',2,'b');
%curv2_bezier_plot(p1_1_dx,np,'b-',2,'b');

%suddivide la seconda curva nei due punti di intersezione
%per ottenere il tratto centrale
[p2_sx,p2]=decast_subdiv(bez2,t2(1));
%curv2_bezier_plot(p2_sx,np,'b-',2,'b');
%curv2_bezier_plot(p2,np,'b-',2,'b');
[p2,p2_2_dx]=decast_subdiv(p2,t2(2));
%curv2_bezier_plot(p2,np,'b-',2,'b');
%curv2_bezier_plot(p2_2_dx,np,'b-',2,'b');

%% 4-
%join dei due tratti centrali (curve di Bézier) e chiusura
tol=1.0e-2;
ppQ = curv2_mdppbezier_join(p1,p2,tol);
ppQ = curv2_mdppbezier_close(ppQ);

%% 5-
open_figure(2);
axis_plot(1,0.0625);
% %colora regione ottenuta
Px=curv2_ppbezier_plot(ppQ, np, 'k-', 3);
point_fill(Px,'g')

%% 6-
% %disegna la regione ottenuta con un colore e il bordo con un altro
open_figure(3);
axis_plot(1,0.0625);
Px=curv2_ppbezier_plot(ppQ,-np);
point_fill(Px,'g','b',1.5);