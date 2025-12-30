function [y,y1]=fun2p(x)
% esempio di funzione da interpolare e sua derivata
% y=0.5 se x>=0; y=-0.5 se x<0
% definita in [-2,2]
m=length(x);
for i=1:m
 if x(i)>=0
   y(i)=0.5;
   y1(i)=0;
 else
   y(i)=-0.5;
   y1(i)=0;
 end
end
