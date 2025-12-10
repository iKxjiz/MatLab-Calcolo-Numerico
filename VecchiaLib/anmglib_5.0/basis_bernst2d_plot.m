function basis_bernst2d_plot(gu,gv,a,b,c,d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function basis_bernst2d_plot(gu,gv,a,b,c,d)
%Valuta e disegna la base di Bernstein bivariata
%gu,gv  --> grado
%a,b  --> intervallo di definizione in u
%c,d  --> intervallo di definizione in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bma=b-a;
dmc=d-c;
%l'intervallo [a,b]x[c,d] viene discretizzato in mxm punti
m=30;
u=linspace(a,b,m);
v=linspace(c,d,m);
figure('Name','Polinomi base')
%base di Bernstein
uu=(u-a)./bma;
vv=(v-c)./dmc;
zx=bernst_val(gu,uu);
zy=bernst_val(gv,vv);

%disegno di tutte le funzioni base
 figure(1);
 view(45,30);
 [X,Y]=meshgrid(u,v);
 k=0;
 for i=1:gu+1
    for j=1:gv+1
       k=k+1;
       subplot(gu+1,gv+1,k);
       Z=zy(:,j)*zx(:,i)';
       %disegna funzione base (i,j)
       mesh(X,Y,Z);
    end
 end

