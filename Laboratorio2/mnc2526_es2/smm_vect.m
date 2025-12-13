%minimo, massimo e media di una serie di valori
clear
clc

x=[3,7,5,1,4,9,2,8];
k = fix(100.*rand([1,10]));

[max, min] = mm_vect(x);
fprintf('%4s\n',mat2str(x));
fprintf('min = %.2f ----- max = %.2f',min, max);