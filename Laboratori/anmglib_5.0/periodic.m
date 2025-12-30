function curv=periodic(curv,order)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv=periodic(curv,order)
%
%curv  --> struttura di una curva spline o nurbs nD:
%          curv.deg --> grado della curva
%          curv.cp  --> lista dei punti di controllo (ncp)xnD 
%          curv.knot  --> vettore dei nodi (ncp+g+1)
%          curv.w   --> coefficienti pesi
%ordine --> ordine di continuita' richiesto nel punto di chiusura
%curv  <-- curva spline e nurbs nD modificata per essere periodica
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%grado
n=curv.deg;
if (order >= n)
    disp('Errore: ordine di continuita'' troppo elevato')

else

    %numero di cp della curva
    npkp1=length(curv.cp(:,1));
    for i=1:order+1
        curv.cp(npkp1-order-1+i,:)=curv.cp(i,:);
    end
    %estremo sinistro intervallo di def
    a=curv.knot(n+1);
    %numero totale nodi partizione estesa
    nkt=length(curv.knot);
    %numero nodi interni partizione nodale
    K=nkt-2*(n+1);
    %estremo destro intervallo di def
    b=curv.knot(nkt-n);
    %replica degli intervalli e quindi definizione
    %dei nodi aggiuntivi
    for i=n+1:-1:order+2
        curv.knot(i)=a;
    end
    j=1;
    for i=order+1:-1:2
        curv.knot(i)=a-(b-curv.knot(n+K+2-j));
        j=j+1;
    end
    curv.knot(1)=curv.knot(2);
    
    for i=nkt-n:nkt-order-1
        curv.knot(i)=b;
    end
    j=1;
    for i=nkt-order:nkt-1
        curv.knot(i)=b+(curv.knot(n+1+j)-a);
        j=j+1;
    end
    curv.knot(nkt)=curv.knot(nkt-1);
end

end

