function [y,y1]=fun1p(x)
% esempio di funzione da interpolare e sua derivata
% definita in [-3.14,3.14]
y=sin(x)-sin(2.*x);
% definita in [-3.14,3.14]
y1=cos(x)-2.*cos(2.*x);
