function y=d2_effe5(x)
%*************************************
% funzione effe5 da integrare in [0,1]
% y=sqrt(1-x.^2).*exp(x)
% valore integrale: 1.243950501416469
%*************************************
%derivata seconda
y=exp(x).*(1 - x.^2).^(1/2) - exp(x)./(1 - x.^2).^(1/2) - (x.^2.*exp(x))./(1 - x.^2).^(3/2) - (2.*x.*exp(x))./(1 - x.^2).^(1/2);
end