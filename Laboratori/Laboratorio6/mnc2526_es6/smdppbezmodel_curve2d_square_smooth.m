%script smdppbezmodel_curved2d_square_smooth.m
%esempio di modellazione procedurale di un quadrato con i corner smussati
function main()
close all

open_figure(1);
grid on;
axis_plot(1.25, 0.05)

%definiamo il quadrato centrato nell'origine e lato 2
Q=[1,1; -1,1; -1,-1; 1,-1; 1,1];
point_plot(Q, 'g:*', 3, 'r', 'r', 10);

%definisce due segmenti come curva di Bézier a tratti di gradi 2 e 1
mdppP.deg=[2,1];
%smussiamo gli angoli: coefficiente di smooth
% d=0.5;
% d=2/3; %0.66666
d=0.59; % 0.4 meno smooth, 0.70 più smooth, max 1
mdppP.cp=[Q(1,:)+[0,-d];
    Q(1,:);
    Q(1,:)+[-d,0];
    Q(2,:)+[d,0]];
mdppP.ab=[0,1,2];
point_plot(mdppP.cp,'ro:',3,'k','r');

R=get_mat2_rot(pi/2);
mdppQ=mdppP;
mdppQ.cp=point_trans(mdppP.cp,R);

tol=1.0e-2;
mdppP=curv2_mdppbezier_join(mdppP,mdppQ,tol);

R=get_mat2_rot(pi);
mdppQ=mdppP;
mdppQ.cp=point_trans(mdppP.cp,R);

mdppP=curv2_mdppbezier_join(mdppP,mdppQ,tol);

mdppP=curv2_mdppbezier_close(mdppP);

np=20;
%disegna curva di bezier a tratti multi-grado finale
Pxy=curv2_mdppbezier_plot(mdppP,np,'k-',3);
%riempie la forma con un colore
%point_fill(Pxy,'cyan')

%salviamo la curva generata come file .db
% curv2_mdppbezier_save('mdppbez_square_smooth.db',mdppP);
end
