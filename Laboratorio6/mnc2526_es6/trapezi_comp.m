function I=trapezi_comp(funz,a,b,n,fp)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula dei trapezi composta;
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di sottointervalli
% fp   --> 0 no visualizzazione grafica
%          1 visualizzazione funzione e interpolante a tratti
% I    <-- approssimazione dell'integrale
% Vengono effettuate n+1 valutazioni di funzione

if ischar(funz)
    fun=str2func(funz);
else
    fun=funz;
end
%codice per formula trapezi composta
h=(b-a)/n;
x=linspace(a,b,n+1);
y=fun(x);
I=h*(0.5*(y(1)+y(n+1))+sum(y(2:n)));

%visualizzazione grafica
if (fp>0)
     figure(1)
     title('Trapezi Composto');
     hold on;
    %grafico funzione integranda
     xv=linspace(a,b,200);
     yv=fun(xv);
     plot(xv,yv,'b-','LineWidth',1.5);
    %grafico valutazioni trapezi composta
     y=fun(x);
     plot(x,y,'r-+','LineWidth',1.5);
     plot([a,b],[0,0],'k','LineWidth',1.5);
    %piecewise linear interpolation
     for i=1:n+1
      plot([x(i),x(i)],[0,y(i)],'r-','LineWidth',1.5);
     end
end

end
