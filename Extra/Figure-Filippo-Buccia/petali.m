close all;
clear all;

open_figure(1);
function [x,y,xder,yder]=cerchio(t)
x = cos(t);
y = sin(t);
xder = -sin(t);
yder = cos(t);
end
function x=chebyshev2( a,b,n )
%input:
%  a,b --> estremi intervalo in cui mappare i punti
%  n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1
%punti di Chebishev seconda specie
for i=0:n
    x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
end
end


%% creazione prima circonfernza
a=0;
b=2*pi;
np=50;
m=8;
t=chebyshev2(a,b,m);
[x,y,xder,yder]=cerchio(t);
Q=[x'+1,y'+1];
Q2=[xder',yder'];
c1=curv2_ppbezierCC1_interp_der(Q,Q2,t);
% curv2_ppbezier_plot(c1,np,'b');
%% creo rotazione e circonferenze
M=get_mat2_rot(2*pi/7);
c2=c1;
c2.cp= point_trans(c1.cp,M);
% Px=curv2_ppbezier_plot(c2,np,'g');

c3=c2;
c3.cp= point_trans(c2.cp,M);
% Px=curv2_ppbezier_plot(c3,np,'r');

c4=c3;
c4.cp= point_trans(c3.cp,M);
% Px=curv2_ppbezier_plot(c4,np,'r');

c5=c4;
c5.cp= point_trans(c4.cp,M);
% Px=curv2_ppbezier_plot(c5,np,'r');

c6=c5;
c6.cp=point_trans(c5.cp,M);
% Px=curv2_ppbezier_plot(c6,np,'r');

c7=c6;
c7.cp=point_trans(c6.cp,M);
% Px=curv2_ppbezier_plot(c7,np,'r');
%% punti intersezione
[pip,t1,t2]=curv2_intersect(c1,c2);
disp(pip');
%% divido per creare primo petalo
[~,p]=ppbezier_subdiv(c1,t1(2));
[s,~]=ppbezier_subdiv(p,t1(1));
% curv2_ppbezier_plot(s,np,'r');

[~,g]=ppbezier_subdiv(c2,t2(1));
[h,~]=ppbezier_subdiv(g,t2(2));
% curv2_ppbezier_plot(h,np,'r');

Petalo= curv2_mdppbezier_join(s,h,1.0e-2);
Px=curv2_mdppbezier_plot(Petalo,np,'r');
point_fill(Px,'r','k');

%% rotazione
pet=Petalo;
for i=1:6
    pet.cp=point_trans(pet.cp,M);
    Px2=curv2_mdppbezier_plot(pet,np,'k');
    point_fill(Px2,'r');
end

pet2=Petalo;
S=get_mat_scale([0.5,0.5]);
R3=get_mat2_rot(2*pi/2);
M=S*R3;
% T=get_mat_trasl([0.7,0]);
% T=get_mat_trasl([])

pet2.cp=point_trans(pet2.cp,M);
% curv2_ppbezier_plot(pet2,np,'k');
R=get_mat2_rot(2*pi/7);
for i=0:7
    pet2.cp=point_trans(pet2.cp,R);
    Px=curv2_mdppbezier_plot(pet2,np,'k');
    point_fill(Px,'g');
end
%% cerchio

[Xx,Yy]=circle2_plot([0,0],0.25,np,'k');
point_fill([Xx',Yy'],'b');