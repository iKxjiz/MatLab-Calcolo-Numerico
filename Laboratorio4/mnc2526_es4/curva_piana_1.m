function [x,y] = curva_piana_1(t)
% C(t) = (6t − 9t2 + 4t3, −3t2 + 4t3)T t ∈ [−0.5, 1.5]
x = 6*t - 9*t.^2 + 4*t.^3;
y = -3*t.^2 + 4*t.^3;
end