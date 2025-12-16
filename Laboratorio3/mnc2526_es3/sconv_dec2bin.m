%programma conv_dec2bin.m
%************************************************
%Programma per la conversione da base 10 a base 2
%di un numero in virgola e verifica se la rappre-
%sentazione è esatta o meno
%************************************************
clear all
clc

disp('Converte un reale (parte intera e frazionaria) da base 10 a base 2');
z=input('dai il numero reale: ');
k=input('dai il numero max. di cifre per la parte frazionaria: ');
b=2;
zint=fix(z);
z=z-zint;
%usa la funzione di libreria dec2bin che converte numeri interi da base 10 a base 2
x=dec2bin(zint);
l=0;
while (z<0 || z>0) && l<k
   l=l+1;
   y(l)=fix(z*b);
   z=z*b-y(l);
end

fprintf('Il numero nella nuova base e'':\n');
%Stampa parte intera
for i=1:length(x)
   fprintf('%1d',x(i)-48);
end
%Stampa punto radice e se del caso uno 0 come parte frazionaria
if (l==0)
   fprintf('.0');
else
   fprintf('.');
end
%Stampa parte frazionaria
for i=1:l
   fprintf('%1d',y(i));
end
fprintf('\n');
%Stampa di controllo su rappresentazione esatta
if (z==0)
   fprintf('Rappresentazione esatta\n');
else
   fprintf('Rappresentazione NON esatta\n');
end
