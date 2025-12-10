function main()
clc
clear all;

open_figure(1);

%% STRUTTURA DEL CERCHIO 
% Bordo cerchio esterno 
tpar = linspace(0,2*pi,8); 
[xp,yp,xp1,yp1] = cp2_circle(tpar); 
ppC = curv2_ppbezierCC1_interp_der([xp',yp'],[xp1',yp1'],tpar); 
 curv2_ppbezier_plot(ppC,40,'r-');

% Bordo cerchio interno
ppc=ppC;
S=get_mat_scale([0.70,0.70]);
ppc.cp=point_trans(ppc.cp,S);
curv2_ppbezier_plot(ppc,40,'r-');

% Traslo la circonferenza
ppV=ppC;
ppv=ppc;
T = get_mat_trasl([0.9,-0.9]);
ppV.cp=point_trans(ppV.cp,T);
ppv.cp=point_trans(ppv.cp,T);
curv2_ppbezier_plot(ppV,40,'g-');
curv2_ppbezier_plot(ppv,40,'g-');

% Traslo la circonferenza
ppB=ppC;
ppb=ppc;
T = get_mat_trasl([1.8,-1.8]);
ppB.cp=point_trans(ppB.cp,T);
ppb.cp=point_trans(ppb.cp,T);
curv2_ppbezier_plot(ppB,40,'b-');
curv2_ppbezier_plot(ppb,40,'b-');

%% INTERSECO LA CIRCONFERENZA VERDE CON LE ALTRE DUE E MI TROVO I PUNTI
% interseco circ. rossa interna con quella verde esterna
[IP,td1,td2]=curv2_intersect(ppc,ppV);
% fprintf(' punti circonferenze C e V \n');
% disp(IP');
point_plot(IP','yo');

% interseco la circ. rossa interna con quella verde interna
[IP,te1,te2]=curv2_intersect(ppc,ppv);
% fprintf(' punti circonferenze V e b \n');
% disp(IP');
point_plot(IP','yx');

% interseco la circ. verde interna con quella blu esterna
[IP,tf1,tf2]=curv2_intersect(ppv,ppB);
% fprintf(' punti circonferenze C e v \n');
% disp(IP');
point_plot(IP','ys');

% interseco la circ. verde esterna con quella blu esterna
[IP,tg1,tg2]=curv2_intersect(ppV,ppB);
% fprintf(' punti circonferenze C e v \n');
% disp(IP');
point_plot(IP','y*');

%% PRENDO LE PARTI CHE MI INTERESSANO
% prendo parte della circonferenza verde grande
[~,cdx]=ppbezier_subdiv(ppV,td2(2));
[cdx,~]=ppbezier_subdiv(cdx,tg1(1));
% curv2_ppbezier_plot(cdx,40,'m-');

% prendo parte della circonferenza verde piccola
[~,cdx1]=ppbezier_subdiv(ppv,te2(2));
[cdx1,~]=ppbezier_subdiv(cdx1,tf1(1));
% curv2_ppbezier_plot(cdx1,40,'m-');

% prendo trattino in basso
[sdx,~]=ppbezier_subdiv(ppB,tg2(1));
[~,sdx]=ppbezier_subdiv(sdx,tf2(1));
% curv2_ppbezier_plot(sdx,40,'m-');

% prendo trattino in alto
[~,sdx1]=ppbezier_subdiv(ppc,te1(2));
% curv2_ppbezier_plot(sdx1,40,'m-',2);
[sdx2,~]=ppbezier_subdiv(ppc,td1(2));
% curv2_ppbezier_plot(sdx2,40,'m-',2);
sdxa=curv2_ppbezier_join(sdx1,sdx2,1.0);
% curv2_ppbezier_plot(sdxa,40,'m',2);

%% UNISCO LE PARTI CHE MI INTERESSANO
ppa=curv2_ppbezier_join(cdx1,sdxa,1.0);
ppe=curv2_ppbezier_join(ppa,sdx,1.0);
metaS=curv2_ppbezier_join(ppe,cdx,1.0);
% curv2_ppbezier_plot(ppe1,40,'m-');

open_figure(2);
set(gca, 'color', [0.7 0.9 1]);
np=40;

Px=curv2_ppbezier_plot(ppC,-np);
point_fill(Px,'r','k');
Px=curv2_ppbezier_plot(ppc,-np);
point_fill(Px,[0.7 0.9 1],'k');

Px=curv2_ppbezier_plot(ppB,-np);
point_fill(Px,'b','k');
Px=curv2_ppbezier_plot(ppb,-np);
point_fill(Px,[0.7 0.9 1],'k');

Px=curv2_ppbezier_plot(metaS,-np);
point_fill(Px,'g','k');

metaD=metaS;
T = get_mat_trasl([1.8,-1.82]);
R = get_mat2_rot([pi]);
M = T*R;
metaD.cp=point_trans(metaD.cp,M);
Px=curv2_ppbezier_plot(metaD,-np);
point_fill(Px,'g','k');

end

function [x, y, xd, yd] = cp2_circle(t)
    x = cos(t);
    y = sin(t);
    xd = -sin(t);
    yd = cos(t);
end
