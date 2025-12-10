function y=polfun1(x)
%
%valutazione del polinomio
% y=1+x/2+x.^2/6+x.^3/24;
%
y=1+x.*(0.5+x.*(1./6+x.*(1./24+x.*4./120)));
% %y=1+x.*(1/2+x.*(1./4+x.*(1./8+x.*1./16)));
