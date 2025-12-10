%***************************************************
% script sexpression.m
% Valutazione dell'espressione ((1+x)-1)/x
% con x numero finito e determinare E_ALG;
% utilizzare il programma sconv_dec2bin.m per
% determinare se i valori x utilizzati hanno una
% rappresentazione esatta in base 2 a 53 cifre
%***************************************************
clear
clc

%assegna un valore alla x e scommentare
x= 10^-9;

%calcolo espressione
y=((1+x)-1)/x;

%stampa risultato e test
fprintf(' x                      y\n');
fprintf('%22.15e %22.15e\n\n',x,y);
fprintf('ErrAlg = %22.15e\n',abs((y-1))/1);
if (y==1.0)
  fprintf('calcolo esatto\n');
else
  fprintf('calcolo errato\n');
end
