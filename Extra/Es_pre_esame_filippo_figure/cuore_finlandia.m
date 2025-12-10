close all;
clear all;
open_figure(1);



%% Cuore esterno
%Interpolazione cuore
ppC.ab = [0, 1];
ppC.deg = 9;
ppC.cp = [
    0.0, 0.0;
    0.3, 0.2;
    0.3, 0.6;
    0.0, 0.6;
    -0.5, 0.0;
    0.5, 0.0;
    0.0, 0.6;
    -0.3, 0.6;
    -0.3, 0.2;
    0.0, 0.0
];

S = get_mat_scale([6, 6]);
ppC.cp = point_trans(ppC.cp, S);

%disegno cuore
curv2_ppbezier_plot(ppC,60,'k-',2,'k');


%% Cuore interno
ppCS = ppC;

%scalare rispetto al raggio
S=get_mat_scale([0.95,0.95]);
ppCS.cp=point_trans(ppCS.cp,S);

%disegno cerchio
curv2_ppbezier_plot(ppCS,40,'k-',2,'k');

%% rettangolo verticale
r1.ab = [0, 1, 2, 3, 4];
r1.deg = 1;

r1.cp = [
    -0.2, 1;
    -0.7, 1;
    -0.7, -1;
    -0.2, -1;
    -0.2, 1];

curv2_ppbezier_plot(r1, 30, 'k');
r1 = curv2_ppbezier_de(r1, 2);  

%% rettangolo orizzontale
r2.ab = [0, 1, 2, 3, 4];
r2.deg = 1;
r2.cp = [
    -1, 0.25;
    -1, -0.25;
    1, -0.25;
    1, 0.25;
    -1, 0.25];
curv2_ppbezier_plot(r2, 30, 'k');
r2 = curv2_ppbezier_de(r2, 2); 


%% Striscia verticale

%intersezione
[I, t1, t2] = curv2_intersect(ppCS, r1);
disp(I');

%suddivisione curva sopra
[~,c1]= ppbezier_subdiv(ppCS, t1(3));
[c1,~]= ppbezier_subdiv(c1, t1(2));

%suddivisione rettangolo sinistra
[~, r11] = ppbezier_subdiv(r1, t2(2));
[r11, ~] = ppbezier_subdiv(r11, t2(1));

verticale1 = curv2_ppbezier_join(c1, r11, 1.0e-2);
curv2_ppbezier_plot(verticale1, 30, 'b');


%suddivisione curva sotto
[~,c2]= ppbezier_subdiv(ppCS, t1(1));
[c2,~]= ppbezier_subdiv(c2, t1(4));


%suddivisione rettangolo destra
[~, r12] = ppbezier_subdiv(r1, t2(4));
[r12, ~] = ppbezier_subdiv(r12, t2(3));


verticale2 = curv2_ppbezier_join(c2, r12, 1.0e-1);

verticale = curv2_ppbezier_join(verticale1, verticale2, 1.0e-1);
curv2_ppbezier_plot(verticale, 30, 'b');

%% Striscia orizzontale
%intersezione
[I, t1, t2] = curv2_intersect(ppCS, r2);
disp(I');

%suddivisione curva sinistra
[~,c2]= ppbezier_subdiv(ppCS, t1(1));
[c2,~]= ppbezier_subdiv(c2, t1(2));

%suddivisione rettangolo sinistra
[~, r21] = ppbezier_subdiv(r2, t2(3));
[r21, ~] = ppbezier_subdiv(r21, t2(1));

orizzontale1 = curv2_ppbezier_join(c2, r21, 1.0e-2);

orizzontale2 = orizzontale1;
R = get_mat2_rot(pi);
orizzontale2.cp = point_trans(orizzontale2.cp, R);

% %suddivisione curva destra
% [~,c2]= ppbezier_subdiv(ppCS, t1(4));
% [c2,~]= ppbezier_subdiv(c2, t1(3));
% 
% 
% %suddivisione rettangolo destra
% [~, r22] = ppbezier_subdiv(r2, t2(2));
% [r22, ~] = ppbezier_subdiv(r22, t2(4));


% orizzontale2 = curv2_ppbezier_join(c2, r22, 1.0e-1);
curv2_ppbezier_plot(orizzontale2, 30, 'b');

orizzontale = curv2_ppbezier_join(orizzontale1, orizzontale2, 1.0e-1);
% curv2_ppbezier_plot(orizzontale, 30, 'b');

%% Colore
open_figure(2);
np = 30;

%disegno cerchio
curv2_ppbezier_plot(ppC,30,'k-',2,'k');

%coloro striscia verticale
Px = curv2_ppbezier_plot(verticale, -30);
point_fill(Px,'b');

%coloro striscia orizzontale
Px = curv2_ppbezier_plot(orizzontale, -30);
point_fill(Px,'b');
