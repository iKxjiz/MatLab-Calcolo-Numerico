%script sppbezierinterp_p2d.m
%interpolazione con curva cubica a tratti C1 di Hermite di punti 2D
clear
close all

col=['r','g','b','k'];
open_figure(1);

%legge i punti da interpolare da file .txt
Q=load('paperino.txt');
% Q=load('twitter.txt');

%disegna i punti da interpolare
point_plot(Q,'ko:',1,'k','k',4);

%1.chiama function curv2_ppbezierCC1_interp di interpolazione 
%cubica a tratti C1 di Hermite
%2.disegna curva cubica a tratti C1 di interpolazione
%TO DO

