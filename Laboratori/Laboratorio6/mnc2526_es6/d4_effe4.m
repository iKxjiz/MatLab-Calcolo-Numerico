function y=d4_effe4(x)
%*************************************
% funzione effe4 da integrare in [0,1]
% y=4./(1+x.^2)
% valore integrale: 3.141592653589793
%*************************************
%derivata quarta
y=96./(x.^2 + 1).^3 - (1152.*x.^2)./(x.^2 + 1).^4 + (1536.*x.^4)./(x.^2 + 1).^5;
end