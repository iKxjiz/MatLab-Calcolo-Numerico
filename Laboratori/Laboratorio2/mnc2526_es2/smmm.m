%minimo, massimo e media di una serie di valori
clear
clc
%esempio 1:
x=[3,7,5,1,4,9,2,8];
%esempio 2:
%x=fix(100.*rand([1,10]));

minx=min(x);
maxx=max(x);
meanx=mean(x);

fprintf('%4d ',x);
fprintf('\n');
fprintf('min = %f\n',minx);
fprintf('max = %f\n',maxx);
fprintf('mean= %f\n',meanx);