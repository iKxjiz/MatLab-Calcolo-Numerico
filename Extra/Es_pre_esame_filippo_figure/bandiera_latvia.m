close all;
clear all;

open_figure(1);

function [x,y,xder,yder]=cerchio(t)
    x = cos(t);
    y = sin(t);
    xder = -sin(t);
    yder = cos(t);
end

%% Cerchio esterno
a=0;
b=2*pi;
np=40;
m=8;
t=linspace(a,b,m);
[x,y,xder,yder]=cerchio(t);
Q=[x',y'];
Q1=[xder',yder'];
c1=curv2_ppbezierCC1_interp_der(Q,Q1,t);
% c1 = curv2_ppbezierCC1_interp(Q, a, b, 1);
curv2_ppbezier_plot(c1,np,'k');

%% Cerchio interno
%scala
S=get_mat_scale([0.97,0.97]);
c2=c1;
c2.cp=point_trans(c2.cp,S);
% curv2_ppbezier_plot(c2,np,'k');


%% Segmenti
ppB.deg=1;
ppB.ab=[0,1];
ppB.cp=[-1.1,-0.2;
        1.2,-0.2;]
% curv2_ppbezier_plot(ppB,np,'k');
ppB = curv2_ppbezier_de(ppB, 2);

%% intersezione
[c,t1,t2]=curv2_intersect(c2,ppB);
disp(c');

%% fascia inferiore

%spezzata 
[~,s]=ppbezier_subdiv(ppB,t2(1));
[t,~]=ppbezier_subdiv(s,t2(2));
% curv2_bezier_plot(t,np,'r',2,'r');

% curva
[~,ss]=ppbezier_subdiv(c2,t1(1));
[tt,~]=ppbezier_subdiv(ss,t1(2));
% curv2_bezier_plot(tt,np,'r',2,'r');

sotto = curv2_ppbezier_join(t,tt, 1.0e-2);
Px = curv2_ppbezier_plot(sotto, -20, 'r');
point_fill(Px, 'r');

%% fascia superiore
R = get_mat2_rot(pi);
sopra = sotto;
sopra.cp = point_trans(sopra.cp, R);
Px = curv2_ppbezier_plot(sopra, -20, 'r');
point_fill(Px, 'r');