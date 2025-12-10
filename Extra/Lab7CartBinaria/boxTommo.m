%Questo script carica una curva di Bézier o Bézier atratti,
%trova la curva aligned, trova i suoi punti estremi,
%il suo bounding-box, quindi il tight bounding-box

close all
open_figure(1);
axis_plot(1,0.125);

%carica curva
bezQ=curv2_bezier_load('c2_bez_curv.db');

%numero punti di disegno
np=40;
%disegna prima curva
curv2_bezier_plot(bezQ,np,'b-',2,'b');
%disegna poligonale di controllo
point_plot(bezQ.cp,'r-o',1,'k','r',8);
[ncp,~]=size(bezQ.cp);

%determina la curva aligned di una curva di Bézier
[bezP,angle]=align_curve(bezQ);

curv2_ppbezier_plot(bezP,100,'r-');

np = 100;
t_values = linspace(0, 1, np);
% Initialize array to store curve points
curve_points = zeros(2, np);
% Evaluate points on the Bezier curve using de Casteljau's algorithm
for i = 1:np
t = t_values(i);
curve_points(:, i) = decast_val(bezP, t);
end

rect = bounding_box(curve_points');
%bounding-box = più piccolo rettangolo contenente i punti
%estremi ed il primo ed ultimo punto della curva
%definisce il bounding-box come una curva di

rotation_matrix = [cos(angle), -sin(angle); sin(angle), cos(angle)];
rect = (rotation_matrix * rect')';
rect= rect +bezQ.cp(1,:);

plot(rect(:,1),rect(:,2),'m.--')

%TO DO
% TRASLARE IL PRIMO PUNTO SULL'ORIGINE E TROVARE ANGOLO DI INCLINAZIONE, 
% APPLICARE TRASFORMAZIONI E RIPORTARE A POS INIZIALE (ALPHA = ATAN(Y,X))
%trasformazione inversa e sua applicazione al bounding-box
%M=...;

%tight.cp=point_trans_plot(rect.cp,M);

% area=curv2_ppbez_area(tight);
% fprintf('Area = %e \n',area)
% point_plot(rect.cp,'k-',1.5);

%function per determinare una curva aligned
%bezQ=align_curve(bezP);
%curv2_ppbezier_plot(bezQ,100,'r-');

function [bezP,angle]=align_curve(P)
    % Trasla il primo punto di controllo all'origine
    translation_vector = -P.cp(1, :);
    translated_points = P.cp + translation_vector;
    
    % Calcola l'angolo di rotazione per portare l'ultimo punto di controllo sull'asse x
    angle = atan2(translated_points(end, 2), translated_points(end, 1));
    
    % Matrice di trasformazione per la rotazione
    rotation_matrix = [cos(-angle), -sin(-angle); sin(-angle), cos(-angle)];
    
    % Applica la trasformazione di rotazione
    rotated_points = (rotation_matrix * translated_points')';
    
    bezP = P;
    bezP.cp = rotated_points;
end

function out=bounding_box(v)
    min_x = min(v(:,1));
    min_y = min(v(:,2));
    max_x = max(v(:,1));
    max_y = max(v(:,2));
    out = [
        [min_x,min_y];
        [max_x,min_y];
        [max_x,max_y];
        [min_x,max_y];
        [min_x,min_y]
        ];

plot(out(:,1),out(:,2),'g.--')
fill(out(:,1),out(:,2),'g')

plot(v(:,1),v(:,2),'b.--')
fill(v(:,1),v(:,2),'b')
end