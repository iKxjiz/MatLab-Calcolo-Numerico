clear all
close all

%grafic setting
open_figure(1);
hold on;
grid("on");


%cuore punti
C = [0 0.20
    -0.10 0.30
    -0.20 0.25
    -0.15 0.15
    0 0
    ];
%point_plot(C,'r');
bezC = curv2_bezier_interp(C,-1,1,0);
curv2_bezier_plot(bezC,60,'r');

%faccio l'inversa
bezCInv = bezC;
bezCInv.cp = bezC.cp.*[-1 1]; 
curv2_bezier_plot(bezCInv,60,'b');

%
ppbezC = curv2_ppbezier_join(bezCInv,bezC,1.0e-4);
curv2_ppbezier_plot(ppbezC,60,'g',3);

%%%%%%%%%%%%mandala
open_figure(2);
hold on




%cuori verdi
%scala
ppG = ppbezC;
S = get_mat_scale([1.05 1.05]);
ppG.cp = point_trans(ppG.cp,S);

%traslazione dal centro 
C = ppG.cp(1,:);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([0 1.05]);
M = T*T1;
ppG.cp = point_trans(ppG.cp,M);
curv2_ppbezier_plot(ppG,60,'r');

%rotazione tipo mandala
ncurv = 16;
ppG1 = ppG;
teta = linspace(0,2*pi,ncurv);
np =40;
for i=1:ncurv
    ang = teta(i);
    R = get_mat2_rot(ang);
    ppG1.cp = point_trans(ppG.cp,R);
    xy  = curv2_ppbezier_plot(ppG1,np,'k');
    point_fill(xy,'g','b');
end




%cuori rossi

%scala
ppR = ppbezC;
S = get_mat_scale([2.2 2.2]);
ppR.cp = point_trans(ppR.cp,S);

%traslazione dal centro 
C = ppR.cp(1,:);
T = get_mat_trasl(-C);
T1 = get_mat_trasl([0 0.85]);
M = T*T1;
ppR.cp = point_trans(ppR.cp,M);
curv2_ppbezier_plot(ppR,60,'r');

%rotazione tipo mandala
ncurv = 7;
ppR1 = ppR;
teta = linspace(0,2*pi,ncurv);
np =40;
for i=1:ncurv
    ang = teta(i);
    R = get_mat2_rot(ang);
    ppR1.cp = point_trans(ppR.cp,R);
    xy  = curv2_ppbezier_plot(ppR1,np,'k');
    point_fill(xy,'r','b');
end

%cuori blu

ppB = ppbezC;

%scala

S = get_mat_scale([2 2]);
ppB.cp = point_trans(ppB.cp,S);

%mandala
ppB1 = ppB;
ncurv = 4;
teta = linspace(0,2*pi,ncurv);
np =40;
for i=1:ncurv
    ang = teta(i);
    R = get_mat2_rot(ang);
    ppB1.cp = point_trans(ppB.cp,R);
    xy  = curv2_ppbezier_plot(ppB1,np,'k');
    point_fill(xy,'b','b');
end

set(gca, 'color', [0.8, 0.9, 1.0]);




