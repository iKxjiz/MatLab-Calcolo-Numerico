%Si considerino le seguenti funzioni test di cui si vogliono determinare gli zeri
%o radici dell’equazione associata (nella cartella sono presenti le function che le
%implementano insieme alle function delle derivate prime):
% zfun01 f (x) = (4x − 7)/(x − 2) x ∈ [1, 1.9]
% zfun02 f (x) = 1 + 3/x2 − 4/x3 x ∈ [0.5, 6]
% zfun03 f (x) = 1 − 2.5x + 3x2 − 3x3 + 2x4 − 0.5x5 x ∈ [0, 3]
% zfun04 f (x) = xn − 2 x ∈ [0, 2] n = 2, 3, 4
% zfun05 f (x) = x3 − 3x + 2 x ∈ [−2.5, 2]
% zfun06 f (x) = 1/x − 2 x ∈ (0, 4]

clear all
clc
open_figure();
grid on;

curv2_plot('zfunf01',1,1.9,100,'b-',2);
curv2_plot('zfunf02',0.5,6,100,'r-',2);
curv2_plot('zfunf03',0,3,100,'g-',2);
curv2_plot('zfunf04',0,2,100,'k-',2);
curv2_plot('zfunf05',-2.5,2,100,'m-',2);
curv2_plot('zfunf06',0.01,4,100,'c-',2);