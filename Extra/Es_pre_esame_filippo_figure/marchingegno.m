function marchingegno()
close all;
clear all;
open_figure(1);

%% Interpolazione tratto esterno
t = linspace(0, 2 * pi, 40);
[x, y] = f(t);
ppS = curv2_ppbezierCC1_interp([x', y'], 0, 1, 0);
curv2_ppbezier_plot(ppS, 30, 'b-', 2);

%% rettangolo interno
rs.ab = [0, 0.25, 0.5, 0.75, 1];
rs.cp = [
     1.3, 0.3;
     -1.3, 0.3;
     -1.3, -0.3;
     1.3, -0.3;
     1.3, 0.3;];
rs.deg = 1;
rs = curv2_ppbezier_de(rs, 2);
curv2_ppbezier_plot(rs, 30, 'b-', 2);

%% posizionamento struttura verde
open_figure(2);
R = get_mat2_rot(pi/4);
ppS.cp = point_trans(ppS.cp, R);
rs.cp = point_trans(rs.cp, R);

% curv2_ppbezier_plot(rs, 30, 'k-', 2);
% curv2_ppbezier_plot(ppS, 30, 'k-', 2);

%% struttura destra
ppD = ppS;
rd = rs;
R = get_mat2_rot(-pi/2);
ppD.cp = point_trans(ppD.cp, R);
rd.cp = point_trans(rd.cp, R);

% curv2_ppbezier_plot(rd, 30, 'k-', 2);
% curv2_ppbezier_plot(ppD, 30, 'k-', 2);

%% estrapolazione curva interessata
[IEE, t1, tt1] = curv2_intersect(ppS, ppD);
disp(IEE');

[IEI, t2, tt2] = curv2_intersect(ppS, rd);
disp(IEI');

[III, t3, tt3] = curv2_intersect(rs, rd);
disp(III');

[IIE, t4, tt4] = curv2_intersect(rs, ppD);
disp(IIE');

%tagli esterna
[ce, ~] = ppbezier_subdiv(ppS, t1(2));
[~, ce] = ppbezier_subdiv(ce, t2(2));
% curv2_ppbezier_plot(ce, 30, 'g-');

%tagli interna
[~, ci] = ppbezier_subdiv(rs, t3(3));
[ci, ~] = ppbezier_subdiv(ci, t4(2));
% curv2_ppbezier_plot(ci, 30, 'g-');

%tagli segmento inferiore
[~, si] = ppbezier_subdiv(ppD, tt4(2));
[si, ~] = ppbezier_subdiv(si, tt1(2));
% curv2_ppbezier_plot(si, 30, 'g-');

%tagli segmento superiore
[ss, ~] = ppbezier_subdiv(rd, tt2(2));
[~, ss] = ppbezier_subdiv(ss, tt3(3));
% curv2_ppbezier_plot(ss, 30, 'g-');

%unione 
curva = curv2_ppbezier_join(ci, si, 1.0e-1);
curva = curv2_ppbezier_join(curva, ce, 1.0e-2);
curva = curv2_ppbezier_join(curva, ss, 1.0e-2);

%% Colore 
R = get_mat2_rot(pi/2);

for i = 1:4
    Px = curv2_ppbezier_plot(curva, -40);
    if (mod(i, 2) == 0)
        point_fill(Px, 'b');
    else
        point_fill(Px, 'g');
    end

    curva.cp = point_trans(curva.cp, R);
end

end



function [x, y] = f(t)
    r=(abs(cos(t)/2).^5+abs(sin(t)).^5).^(-1/5);
    x = r.*cos(t);
    y = r.*sin(t);
end