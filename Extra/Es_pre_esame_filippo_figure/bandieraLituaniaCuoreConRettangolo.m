% disegnare la bandiera della Lituania con bordo cuore
% (mediante rettangolo per suddividere gli strati)

close all
clear all
clc

open_figure(1);
% axis_plot(1.5,0.25)

% funzione espressione parametrice del cuore
function [x, y] = cuore(t)
    x = 16 .* sin(t).^3;
    y = 13 .* cos(t) - 5 .* cos(2*t) - 2 .* cos(3*t) - cos(4*t);
end

% funzione per restituire il vettore contenente i punti di Chebishev della
% seconda specie
function x = chebyshev2(a,b,n)
    % input:
    % a,b --> estremi intervallo in cui mappare i punti
    % n+1 --> numero di zeri del polinomio di Chebyshev di grado n+1 
    % x <-- vettore contenente i punti di Chebishev della seconda specie
    for i = 0:n
      x(i+1)=0.5.*(a+b)+0.5.*(a-b).*cos(i*pi/n);
    end
end

%% Cuore esterno con bordo nero
param = 2;
% creazione punti che definiscono il cuore
t = chebyshev2(-pi/2,3*pi/2,100);
[x, y] = cuore(t); % creazione cuore (restituisce valori in riga)
Q = [x',y'];
% interpolazione Hermite
ppC = curv2_ppbezierCC1_interp(Q,-pi/2,3*pi/2,param);
% disegno cuore
curv2_ppbezier_plot(ppC, 40, 'k-', 2, 'k');

%% Cuore ridotto per intersezione
ppCS = ppC;
% scala il cerchio
S = get_mat_scale([0.96, 0.96]);
ppCS.cp = point_trans(ppCS.cp, S);
% disegno il cerchio
curv2_ppbezier_plot(ppCS, 40, 'k-', 2, 'k');

%% Rettangolo per intersezione
% si crea la spezzata di Bézier che definisce il rettangolo
ppR.ab = [0, 1, 2, 3, 4]; % intervallo di definizione
x = 20;
y = 4;
ppR.cp = [x, y;
         -x, y;
         -x, -y;
          x, -y;
          x, y]; % punti di controllo del rettangolo
ppR.deg = 1; % grado
% elevato il grado di due gradi la lineare a tratti così da portarla
% a deg = 3, lo stesso del cerchio con cui puoi dovrà essere joinata
Px = curv2_ppbezier_plot(ppR, -40);
ppR = curv2_ppbezierCC1_interp(Px,-1,1,2);
curv2_ppbezier_plot(ppR,40,'k-',2,'k');

%% Punti di intersezione
% chiamata alla function curv2_intersect per determinare i parametri 
% dei punti di intersezione (t1 e t2) delle curve ppCscale e ppR e il 
% numero di punti di intersezioni trovate (IP1P2)
[IP1P2,t1,t2] = curv2_intersect(ppCS,ppR);
IP1P2 = IP1P2';
disp('Matrice 2xn contenente le n intersezioni trovate (1°colonna = x, 2° colonna = y):');
disp(IP1P2);
disp('Parametri t1 dei punti di intersezione per il cerchio scalato:')
disp(t1);
disp('Parametri t2 dei punti di intersezione per il rettangolo:');
disp(t2);
% stampo punti di intersezione
point_plot(IP1P2,'bo');
% mostrare i punti di controllo per capire in che senso gira la curva: ANTIORARIO
% disp('Punti di controllo per capire in che senso gira la curva: ANTIORARIO');
% disp(ppCS.cp);

%% Fascia alta
np = 40;
% suddivisione curva per ottenere curva alta
[~,cdx] = ppbezier_subdiv(ppCS,t1(1));
[csx,~] = ppbezier_subdiv(cdx,t1(4));
curv2_bezier_plot(csx,np,'r-',2,'r');
% suddivisione rettangolo per ottenere lato superiore
[~,rdx] = ppbezier_subdiv(ppR,t2(1));
[rsx,~] = ppbezier_subdiv(rdx,t2(4));
curv2_bezier_plot(rsx,np,'b-',2,'b');
% unione curva e lato fascia alta
tol = 1.0e-2;
ppA = curv2_ppbezier_join(csx,rsx,tol);

%% Fascia bassa
np = 40;
% suddivisione curva per ottenere curva bassa
[csx,~] = ppbezier_subdiv(ppCS,t1(2));
[~, cdx] = ppbezier_subdiv(csx,t1(3));
curv2_bezier_plot(cdx,np,'c-',2,'c');
% suddivisione rettangolo per ottenere lato inferiore
[rsx,~] = ppbezier_subdiv(ppR,t2(2));
[~,rdx] = ppbezier_subdiv(rsx,t2(3));
curv2_bezier_plot(rdx,np,'y-',2,'y');
% unione curva e lato fascia bassa
tol = 1.0e-2;
ppB = curv2_ppbezier_join(cdx, rdx, tol);

%% Colorare risultato finale (Lituania)
np = 50;
open_figure(2);
% colorazione fascia centrale con sfondo rosso senza bordo (coloro
% direttamente il bordo della scalata a cui andrò a sovrascrivere la parte
% sopra e sotto colorate diversamente)
Pcentrale = curv2_ppbezier_plot(ppCS, -np);
point_fill(Pcentrale,[0, 0.5, 0]);
% colorazione fascia alta con sfondo nero senza bordo
Palta = curv2_ppbezier_plot(ppA,-np);
point_fill(Palta,'y');
% colorazione fascia destra con sfondo giallo senza bordo
Pbassa = curv2_ppbezier_plot(ppB, -np);
point_fill(Pbassa,'r');
% disegno cerchio grande bordo
curv2_ppbezier_plot(ppC,40,'k-',2,'k');