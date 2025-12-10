function y=d2_effe1(x)
%**************************************
% funzione effe1 da integrare in [0,12]
% y=exp(sqrt(x)).*sin(x)+2.*x+6
% valore integrale: 68.3532891202...
%**************************************
%derivata seconda
y=(exp(x.^(1/2)).*cos(x))./x.^(1/2) - exp(x.^(1/2)).*sin(x) + (exp(x.^(1/2)).*sin(x))./(4.*x) - (exp(x.^(1/2)).*sin(x))./(4.*x.^(3/2));
end