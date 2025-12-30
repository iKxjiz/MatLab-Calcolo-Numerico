%script sppbezierinterp_curve2d_bicorn.m
%Interpolazione polinomiale con curve di Bezier di due funzioni e
%poi join per definire una curva Bézier a tratti di bordo
function main()
close all
clc
col=['r','g','b','k'];

open_figure(1);
axis_plot(1.5,0.125)

%Disegno delle due funzioni date
mp=150;
a=-1;
b=1;
[x,y1]=curv2_plot('c2_bicorn1',a,b,mp,'k-',1.5);
[x,y2]=curv2_plot('c2_bicorn2',a,b,mp,'k-',1.5);

n=5;
tipo=2; % 1 punti equispaziati, 2 punti di Chebyshev
switch (tipo)
    case 1
        %n+1 punti equispaziati
        t=linspace(a,b,n+1);
    case 2
        %n+1 punti (i nodi) secondo la distribuzione di Chebyshev
        t=chebyshev2(a,b,n);
end

[x, y1] = c2_bicorn1(t);
[x, y2] = c2_bicorn2(t);

% x = alla sua trasposta perchè i sistemi lineari vanno risolti con vettori colonna
% y = alla sua trasposta perchè i sistemi lineari vanno risolti con vettori colonna
x = x';
y1 = y1';
y2 = y2';

Q1 = [x,y1]
Q2 = [x,y2]

%disegno punti di interpolazione
point_plot(Q2,'ko',1,'k');

%cambio di variabile
tt = (t-a)./(b-a); % i punti sono ora tt

%calcolo i polinomi di Bernstein di grado n nei punti tt
%valutazione con l'algoritmo di de Casteljau
B=bernst_val(n,tt);
%calcolo matrice del sistema lineare è già calcolata con i polinomi di Bernstein B

%soluzione dei due sistemi lineari
cx=B\x;
cy1=B\y1;
cy2=B\y2;

%definizione curva di Bézier di interpolazione
Pbez1.deg=n;
Pbez1.ab=[a,b];
Pbez1.cp=[cx,cy1];

Pbez2.deg=n;
Pbez2.ab=[a,b];
Pbez2.cp=[cx,cy2];

%valutazione e disegno curva di Bézier interpolante
curv2_bezier_plot(Pbez1,mp,'b',1.5');
%valutazione e disegno curva di Bézier interpolante
curv2_bezier_plot(Pbez2,mp,'r',1.5');

% Determina i punti di intersezione delle curve P1 e P2 e i loro parametri.
%disegna primo punto della prima curva
point_plot(Pbez1.cp(1,:),'ko',10);
%disegna secondo punto della prima curva
point_plot(Pbez2.cp(1,:),'ko',10);


[IP1P2, t1, t2] = curv2_intersect(Pbez1,Pbez2);
if (length(t1)>0)
    point_plot(IP1P2','go',1,'g','g',8);
    fprintf('IP1P2 = %e %e\n',IP1P2);
    fprintf('t1 = %e\n',t1);
    fprintf('t2 = %e\n',t2);
end

open_figure();
axis_plot(1.5, 0.125);

%suddivide la prima curva nei due punti di intersezione
%per ottenere il tratto centrale
[p1_sx,p1]=decast_subdiv(Pbez1,t1(1));
[p1,p1_dx]=decast_subdiv(p1,t1(2));

%suddivide la seconda curva nei due punti di intersezione
%per ottenere il tratto centrale
[p2_sx,p2]=decast_subdiv(Pbez2,t2(1));
[p2,p2_dx]=decast_subdiv(p2,t2(2));

tol=1.0e-2;
ppQ = curv2_mdppbezier_join(p1,p2,tol);
ppQ = curv2_mdppbezier_close(ppQ);

Px=curv2_ppbezier_plot(ppQ,-np);
point_fill(Px,'g','b',1.5);


open_figure(3);
%axis_plot(3,0.25);

nfig=11;
theta=2*pi/nfig;
B = mean(ppQ.cp(1:end-1, :));
S = get_mat_scale([0.4, 0.4]);
R = get_mat2_rot(pi/2);
T = get_mat_trasl(-B);
Tinv = get_mat_trasl(B);
M = Tinv * R *  S * T;
ppQ.cp=point_trans(ppQ.cp,M);

R=get_mat2_rot(theta);
for i=1:nfig
    ppQ.cp=point_trans(ppQ.cp,R);
    emp=curv2_ppbezier_plot(ppQ,30,'b-');
    point_fill(emp,'g','b',1.5);
end



end