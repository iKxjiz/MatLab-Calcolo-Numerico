function y=d4_effe3(x)
%*************************************
% funzione effe3 da integrare in [1,2]
% y=exp(-x)./x
% valore integrale: 0.170483423687459
%*************************************
%derivata quarta
y=exp(-x)./x + (4.*exp(-x))./x.^2 + (12.*exp(-x))./x.^3 + (24.*exp(-x))./x.^4 + (24.*exp(-x))./x.^5;
end