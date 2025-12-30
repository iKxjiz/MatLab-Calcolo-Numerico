function y=d2_effe4(x)
%*************************************
% funzione effe4 da integrare in [0,1]
% y=4./(1+x.^2)
% valore integrale: 3.141592653589793
%*************************************
%derivata seconda
y=(32.*x.^2)./(x.^2 + 1).^3 - 8./(x.^2 + 1).^2;
end