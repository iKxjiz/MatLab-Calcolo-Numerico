%minimo, massimo e media di una serie di valori
clear
clc

x=[3,7,5,1,4,9,2,8];

[max, min] = mm_vect(x);

fprintf('%4d ',x);
fprintf('\n');
fprintf('min = %f\n',min);
fprintf('max = %f\n',max);
