%Script main_bezier_intersect.m
%Questo script carica due curve di Bézier e determina le intersezioni;
%le curve possono essere anche a tratti
clear
close all
open_figure(1);
axis_plot(1,0.0625);

% 1-
% carica prima curva
bez1=curv2_bezier_load('c2_bezA.db');
bez1=curv2_bezier_reverse(bez1);
%
% %carica seconda curva
bez2=curv2_bezier_load('c2_bezB.db');
bez2=curv2_bezier_reverse(bez2);
%
% %numero punti di disegno
np=40;
% %disegna prima curva
curv2_bezier_plot(bez1,np,'b-',2,'b');
%disegna primo punto della prima curva
point_plot(bez1.cp(1,:),'bo',1,'b','b',8);
%
% %disegna seconda curva
curv2_bezier_plot(bez2,np,'r-',2,'r');
% %disegna primo punto della seconda curva
point_plot(bez2.cp(1,:),'ro',1,'r','r',8);

% 2-
% %interseca le due curve
% [IP1P2, t1, t2] = curv2_intersect(bez1,bez2);
% if (length(t1)>0)
%     point_plot(IP1P2','go',1,'g','g',8);
%     fprintf('IP1P2 = %e %e\n',IP1P2);
%     fprintf('t1 = %e\n',t1);
%     fprintf('t2 = %e\n',t2);
% end

% 3-
% %suddivide la prima curva nei due punti di intersezione
% %per ottenere il tratto centrale
% [p1_sx,p1]=decast_subdiv(bez1,t1(1));
% [p1,p1_1_dx]=decast_subdiv(p1,t1(2));
%
% %suddivide la seconda curva nei due punti di intersezione
% %per ottenere il tratto centrale
% [p2_sx,p2]=decast_subdiv(bez2,t2(1));
% [p2,p2_2_dx]=decast_subdiv(p2,t2(2));

% 4-
% %join dei due tratti centrali (curve di Bézier) e chiusura
% tol=1.0e-2;
% ppQ = curv2_mdppbezier_join(p1,p2,tol);
% ppQ = curv2_mdppbezier_close(ppQ);

% 5-
% %colora regione ottenuta
% Px=curv2_ppbezier_plot(ppQ,-np);
% point_fill(Px,'g')

% 6-
% %disegna la regione ottenuta con un colore e il bordo con un altro
% open_figure(2);
% axis_plot(1,0.0625);
% Px=curv2_ppbezier_plot(ppQ,-np);
% point_fill(Px,'g','b',1.5);