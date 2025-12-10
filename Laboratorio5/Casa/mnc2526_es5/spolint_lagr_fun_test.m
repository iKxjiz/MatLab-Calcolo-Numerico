%script spolint_lagr_fun_test.m
%Codice main che richiama la function polint_lagr_fun
clear
ifun=5;
tipo=2;
fig=0;
% mrange=2.^(2:8);
mrange=4:10:80;
k=1;
for n=mrange
   err(k)=polint_lagr_fun(ifun,n,tipo,fig);
   k=k+1;
end
figure
loglog(mrange,err,'r*-','LineWidth',1.5);  