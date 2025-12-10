%main di esempio per visualizzazione curva di Bezier a tratti
clear
close all
col=['r','g','b','k','m','c','r','g','b','k','m','c'];
open_figure(2);
axis_plot(1.25,0.125);

%curva da file
% ppP=curv2_ppbezier_load('ppbez_esse.db');
% ppP.cp=flip(ppP.cp);

% %curva test: quadrato
% ppP.deg=1;
% ppP.ab=[0,1,2,3,4];
% ppP.cp=[0 0; 2 0; 2 1; 0 1; 0 0];

% %curva test: quadrato centrato in [0,0]
% ppP.deg=1;
% ppP.ab=[0,1,2,3,4];
% ppP.cp=[-1 -1; 1 -1; 1 1; -1 1; -1 -1];

% ppP.deg=3;
% ppP.cp=[0,1;0,1.25;0,1.75;0,2;1,2;2,1;2,0;1.75,0;1.25,0;1,0;1,0.5;0.5,1;0,1];
% ppP.ab = [0 1 2 3 4];
% ppP.cp=flip(ppP.cp);

% %curva da file
% ppP=curv2_ppbezier_load('ppbez_corona.db');
% ppP=curv2_ppbezier_load('ppbez_triang_smooth_proc.db');
ppP=curv2_ppbezier_load('ppbez_square_smooth.db');

% ppP.deg=3;
% ppP.cp=[0,1;0,1.25;0,1.75;0,2]
% ppP.ab = [0 1];
% ppP.cp=flip(ppP.cp);

curv2_ppbezier_plot(ppP,40,'b',2);
% point_plot(ppP.cp,'r-o',1.5);

val = curv2_ppbezier_area(ppP);
if (val < 0)
    ppP=curv2_ppbezier_reverse(ppP);
    val=-val;
end
fprintf('area della curva: %e\n',val); 

%scaliamo ora la curva affinché abbia area unitaria

s=sqrt(1/val);
B=mean(ppP.cp(1:end-1,:));
%definisce matrice di traslazione
T=get_mat_trasl(-B);
%definisce matrice di scala
S=get_mat_scale([s,s]);
%definisce matrice di rotazione
R=get_mat2_rot(pi);
%definisce matrice inversa di traslazione
Tinv=get_mat_trasl(B);
% M=Tinv*R*S*T;
M=Tinv*S*T;
ppP.cp=point_trans(ppP.cp,M);
% ppP.cp=s.*ppP.cp;

curv2_ppbezier_plot(ppP,40,'r',2);

val = curv2_ppbezier_area(ppP);
fprintf('area della curva: %e\n',val);

