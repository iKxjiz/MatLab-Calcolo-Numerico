clear all
close all


%obbiettivo: 
%fare una bandiera dell'italia tra le funzioni paramteriche c2_bicorn e
%calcolare gli errori delle curve 



%%grafic setting
open_figure(1);
hold on;
grid("on");



%%%faccio la funzione della funzione parametrica
%interpolazione
l = linspace(-1,1,8);
bezCurv1 = curv2_bezier_interp([l' c2_bicorn1(l)'],-1,1,0);


bezCurv2 = curv2_bezier_interp([l' c2_bicorn2(l)'],-1,1,0);


%%calcolo l'errore
%valutazione in punti equispaziati per test sull'errore
npt=150;
t=linspace(-1,1,npt);
Pxy=ppbezier_val(bezCurv1,t);
%si fa solo per crf, per casi normali utilizzare quella non der
Qxy=[t' c2_bicorn1(t)'];
%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr1: %e\n',MaxErr);

%valutazione in punti equispaziati per test sull'errore
Pxy=ppbezier_val(bezCurv2,t);
%si fa solo per crf, per casi normali utilizzare quella non der
Qxy=[t' c2_bicorn2(t)'];
%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr2: %e\n',MaxErr);

%%% taglio la parte che mi interessa


[IP1P2,t1,t2]=curv2_intersect(bezCurv1,bezCurv2);
[sx11,dx11]=ppbezier_subdiv(bezCurv1,t1(1));
[sx12,dx12]=ppbezier_subdiv(dx11,t1(2));
[sx21,dx21]=ppbezier_subdiv(bezCurv2,t2(1));
[sx22,dx22]=ppbezier_subdiv(dx21,t2(2));

%%%join
ppbezCurvG = curv2_ppbezier_join(sx12,sx22,1.0e-2);
curv2_ppbezier_plot(ppbezCurvG,60,'r',2);


%%%%costruisco una parte più piccola interna

%punti di massimo
p = linspace(ppbezCurvG.ab(1),ppbezCurvG.ab(3),150);
Punti = ppbezier_val(ppbezCurvG,p);
PuntoMaxY = max(Punti(:,2));
PuntoMinY = min(Punti(:,2));

%metà segmento di metà 
f = (PuntoMaxY-PuntoMinY)*20/100;
ppbezCurv = ppbezCurvG;
S = get_mat_scale([0.80,0.80]);
T = get_mat_trasl([0 f]);
T1 = get_mat_trasl(-[0 f]);
%importante fare T*S e non S*T perchè altrimenti viene una traslazione
%sbagliata
 ppbezCurv.cp = ppbezCurv.cp -[0 f/2];
 ppbezCurv.cp = point_trans(ppbezCurv.cp,T*S);
%altrimenti si può fare anche in questo modo:
%
%ppbezCurv.cp = point_trans(ppbezCurv.cp,T*S*T1);

curv2_ppbezier_plot(ppbezCurv,60,'y');

%%%%%%bandiera dell'italiA
ppbezCurv;

%%divido la curva in 3 fasce

p = linspace(ppbezCurvG.ab(1),ppbezCurvG.ab(3),150);

Pbez = ppbezier_val(ppbezCurv,p);
l = linspace(min(Pbez(:,1)),max(Pbez(:,1)),4);

%prendo i tratti 2-3
bezSegdx = curv2_bezier_interp([l(3),-1;l(3),1],0,1,0);
bezSegsx = curv2_bezier_interp([l(2),-1;l(2),1],0,1,0);

%%trovo le intersezioni

curv2_ppbezier_plot(bezSegdx,60,'r');

[IP1P2,t1,t2]=curv2_intersect(ppbezCurv,bezSegdx);
[sx11,dx11]=ppbezier_subdiv(ppbezCurv,t1(1));
[sx12,dx12]=ppbezier_subdiv(ppbezCurv,t1(2));
% curv2_ppbezier_plot(dx12,60,'g',2);
% curv2_ppbezier_plot(sx11,60,'b',2);

%%join
pbezCent1 = curv2_ppbezier_join(dx12,sx11,1.0e-2); 

[sx21,dx21]=ppbezier_subdiv(bezSegdx,t2(1));
[sx22,dx22]=ppbezier_subdiv(dx21,t2(2));
% curv2_ppbezier_plot(sx22,60,'g',2);ii

%join
sx22 = curv2_ppbezier_de(sx22,pbezCent1.deg-sx22.deg);
bezSgdxF = sx22;
pbezCent2 = curv2_ppbezier_join(pbezCent1,sx22,1.0e-2);

%%altro segmento e join
% bezSegsx
% pbezCent2
[IP1P2,t1,t2]=curv2_intersect(pbezCent2,bezSegsx);
[sx11,dx11]=ppbezier_subdiv(pbezCent2,t1(1));
[sx12,dx12]=ppbezier_subdiv(sx11,t1(2));
  curv2_ppbezier_plot(sx12,60,'p',2);
  curv2_ppbezier_plot(dx11,60,'b',2);ii
%%join

ppbezCentrF1 = curv2_ppbezier_join(sx12,dx11,1.0e-2);

%curv2_ppbezier_plot(ppbezCentrF1,60,'b');

[sx21,dx21]=ppbezier_subdiv(bezSegsx,t2(1));
[sx22,dx22]=ppbezier_subdiv(dx21,t2(2));
 %curv2_ppbezier_plot(sx22,60,'g',2);
 %curv2_ppbezier_plot(dx21,60,'b',2);

%%join centrale
sx22 = curv2_ppbezier_de(sx22,ppbezCentrF1.deg-sx22.deg);

ppbezCentrF = curv2_ppbezier_join(ppbezCentrF1,sx22,1.0e-2);

  xy = curv2_ppbezier_plot(ppbezCentrF,60,'g',2);
 point_fill(xy,'w','w');

%%%%%%

%%parte rossa destra

[IP1P2,t1,t2]=curv2_intersect(ppbezCurv,bezSegdx);
[sx11,dx11]=ppbezier_subdiv(ppbezCurv,t1(1));
[sx12,dx12]=ppbezier_subdiv(dx11,t1(2));


 %join
ppbezSxF = curv2_ppbezier_join(bezSgdxF,sx12,1.0e-2);

 xy = curv2_ppbezier_plot(ppbezSxF,60,'g',2);
point_fill(xy,'w','w');

%%%specchio

ppbezDxF = ppbezSxF;
ppbezDxF.cp  = ppbezSxF.cp.*[-1 1];

 xy = curv2_ppbezier_plot(ppbezDxF,60,'g',2);
point_fill(xy,'w','w');


%%%figura finale in figur 2

open_figure(2);

 xy = curv2_ppbezier_plot(ppbezSxF,-60,'g',2);
point_fill(xy,'r','r');

 xy = curv2_ppbezier_plot(ppbezDxF,-60,'g',2);
point_fill(xy,'g','g');

  xy = curv2_ppbezier_plot(ppbezCentrF,-60,'g',2);
 point_fill(xy,'w','w');


curv2_ppbezier_plot(ppbezCurvG,60,'k',2);

curv2_ppbezier_plot(ppbezCurv,60,'k',2);








function y=c2_bicorn1(x)
%espressione parametrica della curva bicorn1 
%per t in [-1,1]
    y = (2-2*x.^2-sqrt(1-3*x.^2+3*x.^4-x.^6))./(3+x.^2);
end

function y=c2_bicorn2(x)
%espressione parametrica della curva bicorn2  
%per t in [-1,1]

%ricordarsi di mettere il punto x.^2 perchè così elevi tutto il vettore
    y = (1.8-2*x.^2+sqrt(1-3*x.^2+3*x.^4-x.^6))./(3+x.^2);
end



%%%rotazione tipo raggio
open_figure(3);

l = linspace(0,2*pi,30);
[Crf(:,1),Crf(:,2)] = cp2_circle(l);
ppP = curv2_ppbezierCC1_interp(Crf,-1,1,0);



%scaliamo la circonferenza per avere raggio 0.25
ppPC=ppP;
S=get_mat_scale([0.25,0.25]);
ppPC.cp=point_trans(ppPC.cp,S);

xy = curv2_ppbezier_plot(ppPC,-60,'g');
point_fill(xy,'g','k');

%%%faccio per ogni curva di bez

for j=1:5
    if j==1
        ppbez1 = ppbezCurvG;
    elseif j==2
ppbez1 = ppbezCurv;
    elseif j==3
ppbez1 = ppbezSxF;
    elseif j==4
ppbez1 = ppbezDxF;

    else
ppbez1 = ppbezCentrF;
    end


%trasliamo opportunamente la curva chiusa per farla ruotare intorno
%all'origine
C=ppbezCurvG.cp(1,:);
T=get_mat_trasl(-C);
alfa=pi;
T1=get_mat_trasl([0.3,0]);
M=T1*T;
ppbez1.cp=point_trans(ppbez1.cp,M);

ncurv=12;
if j==3
ncurv = 12;
end

bezQ=ppbez1;
teta=linspace(0,2*pi,ncurv);
np=20;
for i=2:ncurv
    ang=teta(i);
    R=get_mat2_rot(ang);
    bezQ.cp=point_trans(ppbez1.cp,R);

    xy = curv2_ppbezier_plot(bezQ,np,'k-',1.5);
    
    if j==3
    point_fill(xy,'r','k-',1.5);
    elseif j==4
    point_fill(xy,'g','k-',1.5);

    elseif j==5 
    point_fill(xy,'w','k-',1.5);

    end
    
end 
end