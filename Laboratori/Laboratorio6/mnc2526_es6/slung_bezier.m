%script slung_bezier.m
%calcolo della lunghezza di una curva 2D di Bezier
clear
close all

open_figure(1);
axis_plot(2.5,0.25);

%definizione di una curva di Bézier
a=0; b=1;
bezP.cp=[0 1;1 2;2 1;1 0];
%bezP.cp=[0 1;1 1;2 1;3 1];
bezP.deg=length(bezP.cp(:,1))-1;
bezP.ab = [a b];

%disegno della curva e suoi punti di controllo
curv2_bezier_plot(bezP,40,'b',2);
point_plot(bezP.cp,'k-o',2);

%calcolo lunghezza della curva e sua stampa
val = curv2_bezier_len(bezP);
fprintf('Lunghezza della curva: %e\n',val);

%% Esempio quadrato

%bezP.cp=[0 1;1 1;1 0;0 0;0 1];
%bezP.deg= 1;
%bezP.ab = [0 1 2 3 4];

%disegno della curva e suoi punti di controllo
%curv2_ppbezier_plot(bezP,40,'b',2);
%point_plot(bezP.cp,'k-o',2);

%calcolo lunghezza della curva e sua stampa
%val = curv2_ppbezier_len(bezP);
%fprintf('Lunghezza della curva: %e\n',val);

%% Esempio esse

%open_figure(2);
%axis_plot(1,0.05);

%bezP = curv2_ppbezier_load('ppbez_esse.db');

%disegno della curva e suoi punti di controllo
%curv2_ppbezier_plot(bezP,40,'b',2);
%point_plot(bezP.cp,'k-o',2);

%calcolo lunghezza della curva e sua stampa
%val = curv2_ppbezier_len(bezP);
%fprintf('Lunghezza della curva: %e\n',val);

%% Esempio quadrato bordi tondi

% bezP.cp=[0 1;1 1;1 0;0 0];
% bezP.deg= 1;
% bezP.ab = [0 1 2 3];
%
% bezQ.ab = [0 1];
% bezQ.deg = 2;
% bezQ.cp = [0 1; -1 0.5; 0 0];
%
%
% ppbez = curv2_mdppbezier_join(bezP, bezQ, 1.0e-2);
%
% %disegno della curva e suoi punti di controllo
% curv2_mdppbezier_plot(ppbez,40,'b',2);
% point_plot(bezQ.cp,'k-o',2);
%
% %calcolo lunghezza della curva e sua stampa
% val = curv2_mdppbezier_len(ppbez);
% fprintf('Lunghezza della curva: %e\n',val);
%
% ppbez = curv2_mdppbezier_reverse(ppbez);
% val2 = curv2_mdppbezier_area(ppbez);
% fprintf('Area della curva: %e\n',val2);
