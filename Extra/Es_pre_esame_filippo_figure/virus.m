function virus()

clear all;
close all;
open_figure();

a=0;
b=2*pi;
np=50;
m=8;
t=linspace(a,b,m);
[x,y,xder,yder]=cerchio(t);
c1=curv2_ppbezierCC1_interp_der([x',y'],[xder',yder'],t);

S=get_mat_scale([0.8,0.8]);
T=get_mat_trasl([0,0.3]);
M=S*T;
c1s=c1;
c1s.cp=point_trans(c1s.cp,M);
curv2_ppbezier_plot(c1,np,'k');
curv2_ppbezier_plot(c1s,np,'k');

[picc,t1,t2]=curv2_intersect(c1,c1s);
disp(picc');
%
% [~,p]= ppbezier_subdiv(c1,t1(2));
% [~,s]=ppbezier_subdiv(p,t1(1));

[p,~]= ppbezier_subdiv(c1s,t2(2));
[~,s]=ppbezier_subdiv(c1s,t2(1));
curv2_ppbezier_plot(s,np,'r');
end

function [x, y, xd, yd] = cerchio(t)
x = cos(t);
y = sin(t);
xd = -sin(t);
yd = cos(t);
end