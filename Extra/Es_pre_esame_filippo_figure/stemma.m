function stemma()
clear all;
close all;
open_figure(1);

%% Interpolazione sinusoide
np = 30;
t = linspace(0, 10*pi, np);
[x, y] = sinusoide(t);
ppS = curv2_ppbezierCC1_interp([x', y'], 0, 10 * pi, 1);
ppS.ab

%% Calcolo errore sinusoide
% t = linspace(0, 1, np);
Pxy = ppbezier_val(ppS, t);
Qxy = [x', y'];
maxErr = max(vecnorm((Qxy - Pxy)'));
fprintf('ErrMax: %d\n', maxErr);


%% Spostamento sinusoide

T = get_mat_trasl([-ppS.cp(1,1),-ppS.cp(1,2)]);
T1 = get_mat_trasl([0.25, 0.50]);
S = get_mat_scale([0.016,0.016]);
M = T1 * S * T;
ppS.cp=point_trans(ppS.cp,M);
curv2_ppbezier_plot(ppS,np,'k');

%% Interpolazione circonferenza

t = linspace(pi/2, 5 * pi / 2, 8);
[x, y, xd, yd] = cerchio(t);
ppC = curv2_ppbezierCC1_interp_der([x', y'], [xd', yd'], t);


%% Spostamento circonferenza
T = get_mat_trasl([0, 1]);
T1 = get_mat_trasl([0.5, 0.28]);
S = get_mat_scale([0.22, 0.22]);
M = T1 * S * T;
ppC.cp = point_trans(ppC.cp, M);
curv2_ppbezier_plot(ppC,np,'k');


%% Scudo 

% curva sinistra
cs.deg=2;
cs.ab=[0,1];
cs.cp=[0.5, 0.1;

        0.1,0.3;

        0.175,0.8];

% curv2_ppbezier_plot(cs,np,'g', 4);

%segmento superiore sinistro
ss.deg=1;
ss.ab=[0,1];
ss.cp=[0.175, 0.8;
       0.5, 0.8];
ss=curv2_ppbezier_de(ss,1);
% curv2_ppbezier_plot(ss,np,'g', 4);

%unione
scudoSinistro = curv2_ppbezier_join(cs,ss,1.0e-2);

%riflessione a destra
[scudoRiflesso,T,R] = align_curve(scudoSinistro);
scudoDestro = scudoRiflesso;
x = scudoDestro.cp(:,1);
y = scudoDestro.cp(:,2);
scudoDestro.cp = [x,-y]; %ribalto rispetto alla y dopo aver trasportato la figura sull'asse x
M = inv(R*T); %trasformazione inversa

%unione parte sinistra e destra
ppScudo = curv2_ppbezier_join(scudoRiflesso,scudoDestro,1.0e-2);
ppScudo.cp = point_trans(ppScudo.cp,M);
curv2_ppbezier_plot(ppScudo,np,'k-');


%% Colorazione
open_figure(2);

%scudo
Px = curv2_ppbezier_plot(ppScudo, -np);
point_fill(Px, 'c', 'b');

%cerchio
% Px = curv2_ppbezier_plot(ppC, -np);
% point_fill(Px, 'k', 'k', 2);

%% Fascie gialle
np = 40;

%prima fascia: sposto sinusoide
T = get_mat_trasl([0, -0.16]);
ppS.cp = point_trans(ppS.cp, T);
[I, t1, t2] = curv2_intersect(ppC, ppS);
% disp(I');

%prima fascia: taglio sinusoide
[~, sf] = ppbezier_subdiv(ppS, t2(1));
[sf, ~] = ppbezier_subdiv(sf, t2(2));

%prima fascia: taglio circonferenza
[~, cc] = ppbezier_subdiv(ppC, t1(1));
[cc, ~] = ppbezier_subdiv(cc, t1(2));

%prima fascia: unione
fascia = curv2_ppbezier_join(sf, cc, 1.0e-2);

%prima fascia: coloro
Px = curv2_ppbezier_plot(fascia, -np);
point_fill(Px, 'y', 'k');


fasciaSuperiore = ppS;
T = get_mat_trasl([0, 0.08]);
for i = 1:4
    fasciaInferiore = fasciaSuperiore;
    fasciaSuperiore.cp = point_trans(fasciaSuperiore.cp, T);

    [I1, t1, t2] = curv2_intersect(fasciaInferiore, ppC);
    [I2, t3, t4] = curv2_intersect(fasciaSuperiore, ppC);
    % disp(I1');
    % disp(I2');

    %taglio sinusoide inferiore
    [~, sf] = ppbezier_subdiv(fasciaInferiore, t1(1));
    [sfi, ~] = ppbezier_subdiv(sf, t1(2));
    % curv2_ppbezier_plot(sfi,np, 'y', 1.5);

    %taglio sinusoide superiore
    [~, sf] = ppbezier_subdiv(fasciaSuperiore, t3(1));
    [sfs, ~] = ppbezier_subdiv(sf, t3(2));
    % curv2_ppbezier_plot(sfs,np, 'y', 1.5);

    %taglio circonferenza sinistra
    [~, cc] = ppbezier_subdiv(ppC, t4(1));
    [ccs, ~] = ppbezier_subdiv(cc, t2(1));
    % curv2_ppbezier_plot(ccs,np, 'y', 1.5);

    %taglio circonferenza destra
    [~, cc] = ppbezier_subdiv(ppC, t2(2));
    [ccd, ~] = ppbezier_subdiv(cc, t4(2));
    % curv2_ppbezier_plot(ccd,np, 'y', 1.5);
    
    %unione
    mezzaSinistra = curv2_ppbezier_join(sfi, ccs, 1.0e-2);
    mezzaDestra = curv2_ppbezier_join(sfs, ccd, 1.0e-2);
    fascia = curv2_ppbezier_join(mezzaSinistra, mezzaDestra, 1.0e-2);

    %coloro fascia
    Px = curv2_ppbezier_plot(fascia, -np);
    if (mod(i,2) == 0)
        point_fill(Px, 'y', 'k');
    else
        point_fill(Px, 'k', 'k');
    end

%ultima fascia: utilizzo ultima fascia superiore già tagliata

%ultima fascia: taglio circonferenza
[ccs, ~] = ppbezier_subdiv(ppC, t4(1));
[~, ccd] = ppbezier_subdiv(cc, t4(2));

%ultima fascia: unione circonferenze e unnione fascia
fascia = curv2_ppbezier_join(ccs, ccd, 1.0e-2);
fascia = curv2_ppbezier_join(fascia, sfs, 1.0e-2);

%ultima fascia: coloro
Px = curv2_ppbezier_plot(fascia, -np);
point_fill(Px, 'k', 'k');
end
end

function [x, y] = sinusoide(t)
    x = t;
    y = sin(t);
end

function [x, y, xd, yd] = cerchio(t)
    x = cos(t);
    y = sin(t);
    xd = -sin(t);
    yd = cos(t);
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

function [ppbezQ, T, R] = align_curve(ppbezP)
    ncp = length(ppbezP.cp(:, 1)); %numero di punti di controllo
    ppbezQ = ppbezP;
    T = get_mat_trasl(-ppbezP.cp(1, :));
    alfa = -atan2(ppbezP.cp(ncp, 2) - ppbezP.cp(1, 2), ppbezP.cp(ncp, 1) - ppbezP.cp(1, 1));
    R = get_mat2_rot(alfa);
    M = R*T;
    ppbezQ.cp = point_trans(ppbezQ.cp, M);
end
