clear all
close all
clc


%% FUNZIONI
function [x, y] = cerchio(t)
x = cos(t);
y = sin(t);
end

function [ppbezQ, T, R] = align_curve(ppbezP)
ncp = length(ppbezP.cp(:, 1)); %numero di punti di controllo
ppbezQ = ppbezP;
T = get_mat_trasl(-ppbezP.cp(1, :));
alfa = -atan2(ppbezP.cp(ncp, 2) - ppbezP.cp(1, 2), ppbezP.cp(ncp, 1) - ppbezP.cp(1, 1));
R = get_mat2_rot(alfa);
M = R*T;
ppbezQ.cp = point_trans(ppbezQ.cp, M);
end


%% CERCHIO BLU
open_figure(1);
% cerchio con bordo blu
t = linspace(-pi/2, 3*pi/2, 12);
[x, y] = cerchio(t);
ppC = curv2_ppbezierCC1_interp([x', y'], -pi/2, 3*pi/2, 2);
curv2_ppbezier_plot(ppC, 40, "b-", 2, "b");


%% QUADRO
% parte sinistra bassa
pp.deg=2;
pp.ab=[0,1];
pp.cp=[0,-2;    %basso
    0,-1;   %centro
    -1,-1]; %sinistra
%point_plot(pp.cp, "g-o");

% parte sinistra alta
pc.deg=2;
pc.ab=[0,1];
pc.cp=[-1,-1;   %sinistra
    0,-1;   %centro
    0,0];   %alto
%point_plot(pc.cp, "g-o");

% unione
sinistra=curv2_ppbezier_join(pp,pc,1.0e-2);
% curv2_ppbezier_plot(sinistra,150,'b');

% riflessione e unione con parte destra
[ppAligned,T,R]=align_curve(sinistra);
T2=ppAligned;
x=ppAligned.cp(:,1);
y=ppAligned.cp(:,2);
ppAligned.cp=[x,-y];
quadro=curv2_ppbezier_join(T2,ppAligned,1.0e-2);
M=inv(R*T);
quadro.cp=point_trans(quadro.cp,M);
Px=curv2_ppbezier_plot(quadro,50, 'r', 2);


%% CURVA VERDE "ASTROID"
% x = 0.8*cos(t)^3,  y = 0.8*sin(t)^3, per t in [pi/2,pi]
% parametri
t_astroid = linspace(pi/2, pi, 6); % t in [pi/2, pi] con 6 punti per interpolazione
x_astroid = 0.8 * cos(t_astroid).^3; % x = 0.8 * cos(t)^3
y_astroid = 0.8 * sin(t_astroid).^3; % y = 0.8 * sin(t)^3
Q_astroid = [x_astroid', y_astroid']; % Lista di punti da interpolare

% interpolazione della curva con Bézier cubica a tratti (Hermite)
a = pi/2; b = pi; % intervallo di interpolazione
param = 2; % parametrizzazione: 2 = corda
pp_astroid = curv2_ppbezierCC1_interp(Q_astroid, a, b, param);

% plot della curva verde
curv2_ppbezier_plot(pp_astroid, 100, 'g', 2); % disegna la curva interpolata in verde

% salva la curva per successive operazioni
pp_astroid_cp = pp_astroid.cp; % punti di controllo della curva verde originale

%% ESTRAPOLARE SOLO LA PARTE DEL QUADRO SOTTO LA CIRCONFERENZA

% Punti di intersezione tra la circonferenza e il quadro
[IP1P2, t1, t2] = curv2_intersect(ppC, quadro);

% Stampa i punti di intersezione
fprintf('Punti di intersezione tra la circonferenza e il quadro:\n');
fprintf('    x         y\n');
IP1P2 = IP1P2'; % Trasposto per una lettura più comoda
disp(IP1P2);

% Disegno i punti di intersezione sulla figura
point_plot(IP1P2, 'yo', 1, 'k', 'y', 10); % Punti di intersezione in giallo

% Suddivido la curva del quadro
% Parte inferiore del quadro (quella che vogliamo mantenere)
[quadro_inferioreSX, ~] = ppbezier_subdiv(quadro, t2(1));  % Parte sotto la circonferenza (da mantenere)
[~, quadro_inferioreDX] = ppbezier_subdiv(quadro, t2(2));  % Parte sotto la circonferenza (da mantenere)

% Disegno della parte inferiore del quadro (quella sotto la circonferenza)
curv2_ppbezier_plot(quadro_inferioreSX, 50, 'y', 2);  % Disegno della parte inferiore del quadro in giallo
curv2_ppbezier_plot(quadro_inferioreDX, 50, 'b', 2);  % Disegno della parte inferiore del quadro in blu

% Unisco le due parti (sinistra e destra) del quadro sotto la circonferenza
tol = 1.0e-2;  % Tolleranza per il join delle curve
quadro_unito = curv2_ppbezier_join(quadro_inferioreSX, quadro_inferioreDX, tol);

% Suddivido la circonferenza
[arco_circonferenza, ~] = ppbezier_subdiv(ppC, t1(2));
[~, arco_circonferenza] = ppbezier_subdiv(arco_circonferenza, t1(1));

%Unisco circonferenza e quadro
quadro_unito = curv2_ppbezier_join(quadro_unito, arco_circonferenza, 1.0e-2);

% Disegno del quadro finale unito
curv2_ppbezier_plot(quadro_unito, 50, 'k-', 2);  % Disegna il quadro finale unito in nero


%% DISEGNO FINALE
open_figure(2);
set(gca,'color',[1.0,1.0,0.8]) % sfondo giallo

% creazione del cerchio piccolo
t = linspace(-pi/2, 3*pi/2, 12);
[x, y] = cerchio(t);
ppCS = curv2_ppbezierCC1_interp([x', y'], -pi/2, 3*pi/2, 2);
PxCS = curv2_ppbezier_plot(ppCS, 40, "b-", 5, "b");
point_fill(PxCS, "r");


%% RUOTARE IL QUADRO ESTRATTO ATTORNO ALLA CIRCONFERENZA
baricentro = mean(quadro_unito.cp);

T = get_mat_trasl([-baricentro(1), -baricentro(2)]);
R = get_mat2_rot(-pi / 4);
Tinv = get_mat_trasl([baricentro(1), baricentro(2)]);
quadro_unito.cp = point_trans(quadro_unito.cp, Tinv * R * T);
curv2_ppbezier_plot(quadro_unito, 30);

R = get_mat2_rot(2 * pi / 7);
for i = 1:7
    quadro_unito.cp = point_trans(quadro_unito.cp, R);
    Px = curv2_ppbezier_plot(quadro_unito, 30);
    point_fill(Px, 'k');
end


%% CALCOLO DELL'AREA DELLA CURVA ROSSA (usare cxc1_val)