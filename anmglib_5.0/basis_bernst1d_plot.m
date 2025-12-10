function basis_bernst1d_plot(g,a,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_bernst1d_plot(g,a,b)
%Valuta e disegna la base di Bernstein univariata
%g    --> grado 
%a,b  --> intervallo di definizione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

bma=b-a;
%l'intervallo [a,b] viene discretizzato in m punti
m=100;
x=linspace(a,b,m);
figure('Name','Base dei polinomi')
hold on;
%cambio di variabile
t=(x-a)./bma;
%base di Bernstein in [0,1]
y=bernst_val(g,t);

%disegno di tutte le funzioni base
title(['Base di Bernstein di grado ',num2str(g)],'FontWeight','normal')
plot(x,y,'linewidth',2);
