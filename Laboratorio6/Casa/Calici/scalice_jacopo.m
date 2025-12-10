%script smdppbezmodel_calice_interp_svg.m
%join di curve per fare un disegno
clc
clear;
close all;
open_figure();

a=0;
b=1;
np=100;
param=0;

%curva di Bézier di grado 2 di interpolazione dei seguenti punti
P1=[3.0 1.0; 4.5 1.5; 5.0 2.0];  % Tre punti == 2 tratti
% pp1.cp=P1;
% pp1.deg=length(pp1.cp(:,1))-1;
% pp1.ab=[a b];
pp1=curv2_ppbezierCC1_interp(P1,a,b,param);

% Nota su P1, ho "Tre punti" quindi sono "Due tratti", pp1.ab = x y z
% cioè, disegna un primo tratto da x a y, e un secondo tratto da y a z

%una curva di Bézier di grado 3 di interpolazione dei seguenti punti
P2=[5.0 4.0; 3.4 4.4; 2.9 5.6; 4.0 8.0]; % Quattro punti == 3 tratti
% pp2.cp=P2;
% pp2.deg=length(pp2.cp(:,1))-1;
% pp2.ab=[a b];
pp2=curv2_ppbezierCC1_interp(P2,a,b,param);

% Nota su P2, ho "Quattro punti" quindi sono "Tre tratti", pp2.ab = x y z k
% vale il ragionamento analogo fatto già per P1 ma in questo caso
% ho un tratto in più da considerare, quello da z a k

%Evidenzio la polinale dei punti di controllo
%point_plot(pp1.cp,'k:o',4);
%point_plot(pp2.cp,'k:o',4);

%Disegna le due curve
%curv2_ppbezier_plot(pp1,np,'b-',2);
%curv2_ppbezier_plot(pp2,np,'b-',2);

%Unisci le due curve con una curva a tratti multi-grado e disegnala
tol=0.5e-2;
ppM1=curv2_mdppbezier_join(pp1,pp2,tol);
ppM1.ab = 0 : length(ppM1.deg);
%ppM1.ab = [0 1 2 3 4 5 6];
Px = curv2_mdppbezier_plot(ppM1,np,'b-',2);

% Occhio : ppM1 non è uno scalare, è un array che contiene
% i gradi di ogni tratto.

% Applico la seguente formula :
%
% perchè la function curv2_mdppbezier_join si concentra su :
% creare i tratti,
% garantire la continuità,
% generare i punti di controllo

% Nota sull'intervallo ab di ppM1; lo ottengo nel seguente modo :
% 2 (pp1) + 3 (pp2) + 1 (giunzione) = 6 tratti
%tratto 1: t ∈ [0,1]
%tratto 2: t ∈ [1,2]
%tratto 3: t ∈ [2,3]
%tratto 4: t ∈ [3,4]
%tratto 5: t ∈ [4,5]
%tratto 6: t ∈ [5,6]

%genera la curva simmetrica e disegnala
SY=get_mat2_symm([6.0 , 0.0],[6.0 , 9.0]);

ppM2 = ppM1;
ppM2.cp=point_trans(ppM2.cp,SY);
curv2_mdppbezier_plot(ppM2,np,'b-',2);

%Unisci le due curve, chiudi la curva finale e disgnala colorata
ppM3=curv2_mdppbezier_join(ppM1,ppM2,tol);
ppM3.ab = 0 : length(ppM3.deg);
ppM4=curv2_mdppbezier_close(ppM3);
point_plot(ppM4.cp,'k:o',3);

PF=curv2_mdppbezier_plot(ppM4,np,'b-',2);

point_fill(PF,'r');
curv2_mdppbezier_plot(ppM4,np,'b-',1.5);

svg_struct=svg_struct_add(ppM4,'b',0.025,'r');
svg_plot(svg_struct);

svg_struct.transform="rotate(180, 5.5, 4.5)";
svg_save(svg_struct,'calice.svg');
%svg_struct=svg_load('calice.svg')
%svg_plot(svg_struct);
%svg_struct.transform
