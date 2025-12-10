%main di esempio di interpolazione polinomiale
%con curve di Bezier e poi unione in una Bézier a tratti
function main()
close all
clear all
clc
% Si intepolino le due seguenti funzioni:
% y=(2-2*x^2-sqrt(1-3*x^2+3*x^4-x^6))/(3+x^2), x in [-1,1]
% y=(1.8-2*x^2+sqrt(1-3*x^2+3*x^4-x^6))/(3+x^2), x in [-1,1]
% con due curve di Bézier di grado 4
col=['r','g','b','k'];

open_figure(1);
axis_plot(1.5,0.25)

%Disegno delle due funzioni date
mp=150;
a=-1;  
b=1;
x=linspace(a,b,mp);
y1=c2_bicorn1(x);
y2=c2_bicorn2(x);
point_plot([x(1),y1(1)],'bo')
point_plot([x',y1'],'b-',1.5);
point_plot([x(1),y2(1)],'ro')
point_plot([x',y2'],'r-',1.5);

%Punti della curva da interpolare; punti di Chebyshev
m=5;
a=-1;  
b=1;
%metodo più corretto per fare l'interpolazione evita errori, mi
%distribuisce in maniera più corretta i punti
t=chebyshev2( a,b,m-1 );
yq=c2_bicorn1(t);
yp=c2_bicorn2(t);

n=m-1;
qb.deg = n;
qb.cp  = [];
qb.ab  = [a,b];
%cambio di variabile
tt=(t-a)./(b-a);
%Metodo di interpolazione: forma di Bernstein
B=bernst_val(n,tt);
%i coeff. sono calcolati risolvendo il sistema lineare;
qb.cp=B\yq';

x=linspace(a,b,n+1);
pb.deg = n;
pb.cp  = [];
pb.ab  = [a,b];
%cambio di variabile
tt=(t-a)./(b-a);
%Metodo di interpolazione: forma di Bernstein
B=bernst_val(n,tt);
%i coeff. sono calcolati risolvendo il sistema lineare;
pb.cp=B\yp';

bezQ.deg=qb.deg;
bezQ.ab=qb.ab;
bezQ.cp=[x',qb.cp];
Qxy=curv2_bezier_plot(bezQ,-mp,'g-',2);

bezP.deg=pb.deg;
bezP.ab=pb.ab;
bezP.cp=[x',pb.cp];
Pxy=curv2_bezier_plot(bezP,-mp,'k-',2);

fprintf('\n---Stampe---\n');
MaxErr1=max(abs(Qxy(:,2)-y1'));
fprintf('MaxErr1: %e\n',MaxErr1);
MaxErr2=max(abs(Pxy(:,2)-y2'));
fprintf('MaxErr2: %e\n',MaxErr2);

%Intersezione delle due curve bezP e bezQ
[IP1P2,t1,t2]=curv2_intersect(bezP,bezQ);
% disp(IP1P2)
% disp(t1)
% disp(t2)

%Suddivisione delle due curve per tenere le due parti centrali
[sx,bezP]=ppbezier_subdiv(bezP,t1(1));
[bezP,dx]=ppbezier_subdiv(bezP,t1(2));
[sx,bezQ]=ppbezier_subdiv(bezQ,t2(1));
[bezQ,dx]=ppbezier_subdiv(bezQ,t2(2));

%Unione delle due parti centrali per dar luogo a curva chiusa
tol=1.0e-2;
ppbez1=curv2_ppbezier_join(bezP,bezQ,1.0e-2);
ppbez1
xy=curv2_ppbezier_plot(ppbez1,50,'m-',2);


%Determinare la circonferenza per interpolazione di Hermite con una curva 
%cubica a tratti ppP
%TO DO
mm = linspace(0,2*pi,8);
mm= chebyshev2(0,2*pi,8);
[P(:,1),P(:,2),P1(:,1),P1(:,2)]=cp2_circle(mm);


% for i=1:8
%     [P(i,1),P(i,2)]=c2_circle(mm(i),1);
%     %funzione del prof
%     [x,y,xp,yp]=cp2_circle(mm(i),1);
%     P1(i,1)=xp;
%     P1(i,2)=yp;
% end


%interpolazione con der (più accurato ) (consigliata in generale più
%accurata) , per aumentare l'accuratezza utilizzare anche chevilshev al
%posto di lispace ( de implementare per bene)
%P1 matrice delle tangenti ,mm linspace dei punti
%param =2 per le curve 0 uniforme
ppP =curv2_ppbezierCC1_interp_der(P,P1,mm);

%interpolazione con ppbeziercc1 mettere in a, b gli estremi della linspace nel caso di 
% una crf invece 0 1 nel caso figura normale 
%mi crea una curva di bezier a tratti 
%ppP = curv2_ppbezierCC1_interp(P,.,2*pi,2);

%mi crea una curva di bezier non a tratti (meno punti) (sconsigliata)
%serve solo per punti piccoli come segmenti perchè le altere non vanno
%ppP = curv2_bezier_interp(P,-1,1,0);

%valutazione in punti equispaziati per test sull'errore
npt=150;
a=0;
b= 2*pi; 
t=linspace(a,b,npt);

Pxy=ppbezier_val(ppP,t);
point_plot(Pxy,'k',2);
% point_plot(Pxy,'r',4)
[x,y]=cp2_circle(t);
Qxy=[x',y'];

%calcola la distanza euclidea fra i punti della curva test
%e della curva di Bézier a tratti interpolante e considera
%la distanza massima
MaxErr=max(vecnorm((Pxy-Qxy)'));
fprintf('MaxErr3: %e\n',MaxErr);

%scaliamo la circonferenza per avere raggio 0.25
ppPC=ppP;
S=get_mat_scale([0.25,0.25]);
ppPC.cp=point_trans(ppPC.cp,S);

%trasliamo opportunamente la curva chiusa per farla ruotare intorno
%all'origine
C=ppbez1.cp(1,:);
T=get_mat_trasl(-C);
alfa=pi;
T1=get_mat_trasl([0.3,0]);
M=T1*T;
% ppbe = ppbez1;
% for i=0:pi/3:2*pi
% R=get_mat2_rot(i);
% M=T1*R*T;
% ppbe.cp=point_trans(ppbez1.cp,M);
% %point_plot(ppbez1.cp(1,:),'bo');
% curv2_ppbezier_plot(ppbe,60,'r',2);
% end
% 
ppbez1.cp=point_trans(ppbez1.cp,M);
%point_plot(ppbez1.cp(1,:),'bo');
curv2_ppbezier_plot(ppbez1,60,'r',2);



open_figure(2);
set(gca,'color',[1.0,1.0,0.8])

%disegnamo le curve chiuse ruotandole
ncurv=12;
bezQ=ppbez1;
teta=linspace(0,2*pi,ncurv);
np=20;
for i=2:ncurv
    ang=teta(i);
    R=get_mat2_rot(ang);
    bezQ.cp=point_trans(ppbez1.cp,R);
    Px=curv2_ppbezier_plot(bezQ,-np,'b-',1.5);
%     curv2_ppbezier_plot(bezQ,np,'b-',1.5);
    point_fill(Px,'g','b-',1.5);
end 
% Pxy=curv2_ppbezier_plot(ppbez1,60,'b-',2,'b');
% point_fill(Pxy,'r','b-',1.5);

%disegnamo la circonferenza
Pxy=curv2_ppbezier_plot(ppPC,40,'b-',2,'b');
point_fill(Pxy,'g','b-',1.5);
end

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

function [x,y,xp,yp]=cp2_circle(t)
%espressione parametrica della curva circonferenza
    x = cos(t);
    y = sin(t);
    xp = -sin(t);
    yp = cos(t);
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