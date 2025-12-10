%script smdppbezmodel_calice_interp_svg.m
%join di curve per fare un disegno
clear
close all;
open_figure(1);

%curva di Bézier di grado 2 di interpolazione dei seguenti punti
P1=[3.0 1.0; 4.5 1.5; 5.0 2.0];
%TO DO

%una curva di Bézier di grado 3 di interpolazione dei seguenti punti
P2=[5.0 4.0; 3.4 4.4; 2.9 5.6; 4.0 8.0];
%TO DO

%Disegna le due curve
%TO DO

%Unisci le due curve con una curva a tratti multi-grado e disegnala
tol=0.5e-2;
%TO DO

%genera la curva simmetrica e disegnala
%TO DO

%Unisci le due curve, chiudi la curva finale e disgnala colorata
%TO DO


% svg_struct=svg_struct_add(mdppbez3,'b',0.025,'r');
% svg_plot(svg_struct);

% svg_struct.transform="rotate(180, 5.5, 4.5)";
% svg_save(mdppbez3,'calice.svg');
% svg_struct=svg_load('calice.svg')
% svg_plot(svg_struct);
% svg_struct.transform
