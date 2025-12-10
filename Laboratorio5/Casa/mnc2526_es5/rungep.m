function [y,y1]=runge(x)
% funzione test di runge definita in [-5,5] e sua derivata
y=1./(1.+x.^2);
y1=-2.*x./((1.+x.^2).^2);
