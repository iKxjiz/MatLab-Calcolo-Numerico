function y=d2_effe3(x)
%*************************************
% funzione effe3 da integrare in [1,2]
% y=exp(-x)./x
% valore integrale: 0.170483423687459
%*************************************
%derivata seconda
y=exp(-x)./x + (2.*exp(-x))./x.^2 + (2.*exp(-x))./x.^3;
end