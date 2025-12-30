function I=simpson_comp(funz,a,b,n,fp)
% Funzione che approssima l'integrale definito di una
% funzione mediante la formula di simpson composta;
% funz --> stringa del nome della funzione integranda
% a,b  --> estremi di integrazione
% n    --> numero di coppie di sottointervalli
% fp   --> 0 no visualizzazione grafica
%          1 visualizzazione funzione e interpolante a tratti
% I    <-- approssimazione dell'integrale
% Vengono effettuate 2n+1 valutazioni di funzione

if ischar(funz)
    fun=str2func(funz);
else
    fun=funz;
end
%codice per formula Simpson composta
k=2*n;
h=(b-a)/k;
x=linspace(a,b,k+1);
y=fun(x);
I=h/3*(y(1)+y(k+1)+2*sum(y(3:2:k))+4*sum(y(2:2:k)));

%visualizzazione grafica
if (fp>0)
     m=21;
     figure(2)
     title('Simpson Composto');
     hold on;
    %grafico funzione integranda
     xv=linspace(a,b,m*n);
     yv=fun(xv);
     plot(xv,yv,'b-','LineWidth',1.5);
    %grafico valutazioni simpson composto
     y=fun(x);
     plot([a,b],[0,0],'k','LineWidth',1.5);
     for i=1:2:k+1
      plot([x(i),x(i)],[0,y(i)],'r-','LineWidth',1.5);
     end
    %piecewise quadratic interpolation 
     t=linspace(0,1,m);
     in=1;
     for i=1:n
        jn=in+m-1;
        k=2*(i-1)+1;
        xp=x(k:k+2);
        yp=y(k:k+2);
        xx(in:jn)=xp(1)+t.*(xp(3)-xp(1));
        yy(in:jn)=lagrval2(yp,xp,xx(in:jn));    
        in=jn;
     end
     plot(x,y,'r+',xx,yy,'g','LineWidth',1.5);
end
