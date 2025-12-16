function [sum] = fcos(x)
sum = 1;
n = 2;
fc2 = factorial(n);
sum = sum-fpower(x,2)/fc2;
n = 4;
fc4 = factorial(n);
sum = sum+fpower(x,4)/fc4;
end

% Funzione secondaria
function y=fpower(x,n)
y=x.^n;
end