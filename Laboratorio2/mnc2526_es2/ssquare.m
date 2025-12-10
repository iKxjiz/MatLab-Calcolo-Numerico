%script ssquare.m
clear
close all

%apre figure
open_figure(1);

%disegna gli assi
axis_plot(3,0.25);

%definizione QUADRATO
P=[0,0; 2,0; 2,2; 0,2; 0,0];

% % definizione STELLA
% axis_plot(75,5);
% P=[50,0; 21,90; 98,35; 2,35; 79,90; 50,0];

%disegna
point_plot(P,'b-o',1.5,'r');