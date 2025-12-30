function [x,y] = curva_piana_2(t)
% C(t) = (t cos(t), t sin(t))T t ∈ [0, 16]
x = t .* cos(t);
y = t .* sin(t);
end