%minimo, massimo e media di una serie di valori
clear all
clc

%TO DO
v = [3,7,5,1,4,9,2,8];
disp(v);
k = fix(100.*rand([1,10])); % fix : arrotondamento per difetto
disp(k);
%v = input("Inserisci il vettore : ");
fprintf("Valori di v")
fprintf("Il massimo in v è %d \n", max(v));
fprintf("Il minimo di in v è %d \n", min(v));
fprintf("Il valore medio in v è %.4f \n", mean(v));

z = fix(100.*rand([1,10]))
fprintf("Il massimo in v è %d \n", max(z));
fprintf("Il minimo di in v è %d \n", min(z));
fprintf("Il valore medio in v è %.4f \n", mean(z));