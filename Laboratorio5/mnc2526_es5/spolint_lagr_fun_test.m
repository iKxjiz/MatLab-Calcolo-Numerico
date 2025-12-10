%script spolint_lagr_fun_test.m
%Codice main che richiama la function polint_lagr_fun
clear
%tipo 1
%ifun=5;  % scala 10^-13 a 10^-1
%ifun=4; % scala 10^0 a 10^7
%ifun=3; % scala 10^-15 a 10^1
%ifun=2; % scala 10^0 a 10^13
ifun=1; % scala 10^-10 a 10^0-10^2

%tipo 2
%ifun=5;  % scala 10^-13 a 10^-1
%ifun=4; % scala 10^0 a 10^7
%ifun=3; % scala 10^-15
%ifun=2; % scala 0.961 a 0.964
%ifun=1; % scala 10^-15 a 10^0

tipo=1;
fig=0;
% mrange=2.^(2:8);
mrange=4:10:80;
k=1;
for n=mrange
   err(k)=polint_lagr_fun_sol(ifun,n,tipo,fig);
   k=k+1;
end
figure
loglog(mrange,err,'r*-','LineWidth',1.5);