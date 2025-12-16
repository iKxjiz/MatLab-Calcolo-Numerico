function [a,b,fun,funp]=def_fun(ip)
%*******************************************************
%function che definisce funzioni test in [a,b] 
% ip  --> indice della funzione  test
% a,b <-- intervallo di definizione
% cP  <-- coefficienti nella base canonica (1,x,x^2,...,x^g):
% cB  <-- coefficienti nella base di Bernstein
%*******************************************************
switch ip
    case 1
      fun=str2func('zfunf01');
      funp=str2func('zfunp01');
      ab=fun();
    case 2
      fun=str2func('zfunf02');
      funp=str2func('zfunp02');
      ab=fun();
    case 3
      fun=str2func('zfunf03');
      funp=str2func('zfunp03');
      ab=fun();
    case 4
      fun=str2func('zfunf04');
      funp=str2func('zfunp04');
      ab=fun();
    case 5
      fun=str2func('zfunf05');
      funp=str2func('zfunp05');
      ab=fun();
    case 6
      fun=str2func('zfunf06');
      funp=str2func('zfunp06');
      ab=fun();
    case 7
      fun=str2func('zfunf07');
      funp=str2func('zfunp07');
      ab=fun();
    case 8
      fun=str2func('zfunf08');
      funp=str2func('zfunp08');
      ab=fun();
    otherwise
        error('Scelta non valida; dare un altro indice.')
end
a=ab(1);
b=ab(2);

function y=zfunf01(x)
%****************************************
% funzione test per la ricerca degli zeri
% y=(4*x-7)/(x-2) def. in [1,1.9]
% sol = 7/4 = 1.75
%****************************************
if (nargin==0)
    y(1)=1.0;
    y(2)=1.9;
else
    y=(4.*x-7)./(x-2);
end

function y=zfunp01(x)
% derivata prima funzione test zfunf01 in [1,1.9]
y=-1./(x-2).^2;

function y=zfunf02(x)
%****************************************
% funzione test per la ricerca degli zeri
% y=1+3/x^2-4/x^3 def. in [0.5,6]
% sol = 1.0
%****************************************
if (nargin==0)
    y(1)=0.5;
    y(2)=6;
else
    y=1+3./x.^2-4./x.^3;
end

function y=zfunp02(x)
% derivata prima funzione test zfunf02 in [-2,6]
y=-6./x.^3+12./x.^4;

function y=zfunf03(x)
%**************************************************
% funzione test per la ricerca degli zeri
% y=1-2.5*x+3*x^2-3*x^3+2*x^4-0.5*x^5 def. in [0,3]
% sol1 = 1, sol2 = 2
%**************************************************
if (nargin==0)
  y(1)=0;
  y(2)=3;
else
  y=1-2.5.*x+3.*x.^2-3.*x.^3+2.*x.^4-0.5.*x.^5;
end

function y=zfunp03(x)
% derivata prima della funzione test zfun03 in [0,3]
y=-2.5+6.*x-9.*x.^2+8.*x.^3-2.5.*x.^4;

function y=zfunf04(x)
%*****************************
% funzione test y=x^n-2 per la 
% ricerca degli zeri in [0,2]
% n=2: sol = 2^(1/2)
% n=3: sol = 2^(1/3)
% n=4: sol = 2^(1/4)
%*****************************
if (nargin==0)
  y(1)=-2;
  y(2)=2;
else 
  n=3;
  y=x.^n-2;
end

function y=zfunp04(x)
% derivata prima funzione test zfun04 in [0,2]
n=3;
y=n.*x.^(n-1);

function y=zfunf05(x)
%**********************************
% funzione test y=x^3-3*x+2 per 
% la ricerca degli zeri in [-2.5,2]
% sol1 = -2, sol2 = 1
%**********************************
if (nargin==0)
  y(1)=-2.5;
  y(2)=2;
else
  y=x.^3-3.*x+2;
end

function y=zfunp05(x)
% derivata prima funzione test zfun05 in [-2.5,2]
y=3.*x.^2-3;

function y=zfunf06(x)
%******************************
% funzione test y=1/x-2 per la 
% ricerca dedgli zeri in [0,4]
% sol =
%******************************
if (nargin==0)
  y(1)=0.1;
  y(2)=4;
else
  y=1./x-2;
end

function y=zfunp06(x)
% derivata prima funzione test zfunf06 in [0,4]
y=-1/x^2;

function y=zfunf07(x)
%*******************************************************
% funzione test per la ricerca degli zeri
% y=tanh(x-1.0) def. in [-1,3]
%*******************************************************
if (nargin==0)
  y(1)=-1;
  y(2)=3;
else
  y=tanh(x-1.0);
end

function y=zfunp07(x)
% derivata prima funzione test zfunf15 in [-1,3]
y=1-tanh(x-1).^2;

function y=zfunf08(x)
%************************************************************
% funzione test y=(1-x)^3-13/3*(1-x)^2*x+25/4*(1-x)*x^2-3*x^3
% per la ricerca degli zeri in [0,1]
% sol =
%************************************************************
if (nargin==0)
  y(1)=0;
  y(2)=1;
else
  y=(1-x).^3-13./3.*(1-x).^2.*x+25./4.*(1-x).*x.^2-3.*x.^3;
end

function y=zfunp08(x)
%************************************************************
% derivata prima funzione test y=(1-x)^3-13/3*(1-x)^2*x+25/4*(1-x)*x^2-3*x^3
%************************************************************
y=(215.*x)./6 - (175.*x.^2)./4 - 22/3;