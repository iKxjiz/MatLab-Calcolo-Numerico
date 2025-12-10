function roots = bezier_clipping(fun,TOL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function roots = bezier_clipping(fun,TOL)
%Determina gli zeri di una funzione polinomiale data nella base di 
%Bernstein in un intervallo (quello di definizione della base);
%utilizza il metodo denominato in letteratura 'Bézier Clipping'
%fun   --> struttura funzione polinomiale nella base di Bernstein 
%TOL   --> tolleranza
%roots <-- vettore delle radici trovate
%Nota. al momento questa function non viene richiamata da nessuna
%      funzione della libreria; la si trova commentata nelle
%      funzioni curv2_bezier_offset.m e curv2_ppbezier_offset.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%inizializzazioni
 f.deg=fun.deg;
 f.cp=fun.cp;
 f.a=fun.ab(1);
 f.b=fun.ab(2);
 nr=0;
 roots=[];
 ascisse=[];
 g=[];
 s=[];
 buf=[];

 [buf,Bezier_idx]=Init_Bezier(buf);
 Bezier_idx = Get_Bezier(Bezier_idx);
 buf=copy_Bezier_f(Bezier_idx,f,buf);
 degree=f.deg;

 while(~Empty_Bezier(Bezier_idx))
    p=Top_Bezier(buf,Bezier_idx);
%    stampa(1,Bezier_idx,buf);
 
    k=1;
    l=1;
    for i=1:p.deg+1
      if (p.cp(i)>0) 
          k=k+1;
      elseif (p.cp(i)<0)
          l=l+1;
      end
    end
    if ((k==p.deg+2) | (l==p.deg+2))
        Bezier_idx = Remove_Bezier(Bezier_idx);  %tutti i coefficienti sono o > 0 oppure < 0
%        stampa(2,Bezier_idx,buf);
    else
        temp=(p.b - p.a)/degree;    
        ascisse(1)=p.a;
        s(1)=1;
        g(1)=1;
        k=2;
        l=2;
        for i=2:p.deg
           ascisse(i) = p.a + (i-1)*temp;
           if ((p.cp(i) - p.cp(1))*(p.b - p.a) - ...
              (ascisse(i) - p.a)*(p.cp(degree+1) - p.cp(1)) >= 0)
               s(k)=i;
               k=k+1;           
                             %s contiene gli indici dei coefficienti che
                             %stanno sopra o sulla retta che congiunge il primo
                             %e l'ultimo dei coefficienti, mentre g quelli che
                             %stanno sotto
           else
               g(l)=i;
               l=l+1;
           end
        end %for   
        ascisse(degree+1)=p.b;
        s(k)=degree+1;
        g(l)=degree+1;
%         disp('s-g')
%         disp(s)
%         disp(g)
      
        if (p.cp(1) >= 0) 
            il=2;
            while ((il<l) & ~det(ascisse(1),p.cp(1),ascisse(g(il)), ...
                    p.cp(g(il)),ascisse(g(il+1)),p.cp(g(il+1))))
              il=il+1;
            end
            x=ascisse(g(il));
            y=p.cp(g(il));
        else
            ik=2;
            while ((ik<k) & det(ascisse(1),p.cp(1),ascisse(s(ik)), ...
                   p.cp(s(ik)),ascisse(s(ik+1)),p.cp(s(ik+1))))
              ik=ik+1;
            end
            x=ascisse(s(ik));
            y=p.cp(s(ik));
        end
        nume=p.cp(1) * (x-p.a);

        if (nume == 0.0)
          xa=p.a;
        else 
          xa=p.a - nume/(y-p.cp(1));    %XA: l'estremo destro
        end
%        plot([p.a,x],[p.cp(1),y],'g-');
        if (p.cp(degree+1) >= 0) 
            il=l-1;
            while ((il>1) & det(ascisse(degree+1),p.cp(degree+1), ...
                   ascisse(g(il)),p.cp(g(il)),ascisse(g(il-1)),p.cp(g(il-1))))
                 il=il-1;
            end
            x=ascisse(g(il));
            y=p.cp(g(il));
        else
            ik=k-1;
            while ((ik>1) & ~det(ascisse(degree+1),p.cp(degree+1), ...
                   ascisse(s(ik)),p.cp(s(ik)),ascisse(s(ik-1)),p.cp(s(ik-1))))
                 ik=ik-1;
            end
            x=ascisse(s(ik));
            y=p.cp(s(ik));
        end
        nume=p.cp(degree+1) * (x - p.b);
      
        if (nume == 0.0)
          xb=p.b;
        else
          xb=p.b - nume/(y-p.cp(degree+1)); %XB: l'estremo sinistro
        end
%        plot([x,p.b],[y,p.cp(degree+1)],'r-');
        temp=abs(xb-xa);
%         plot([xa,xa],[-1,1],'m-');
%         plot([xb,xb],[-1,1],'c-')
        if (temp < TOL*abs(xb))
            nr=nr+1;
            roots(nr)=xa + temp/2;
            Bezier_idx = Remove_Bezier(Bezier_idx);
%            stampa(3,Bezier_idx,buf);
        else
            p = bezier_f_clipping_left(p,xa);
            p = bezier_f_clipping_right(p,xb);
            if (temp>0.8*(ascisse(degree+1)-ascisse(1)))
                temp = xa + (xb-xa)/2;
                [new_p,p] = bezier_f_subdiv_left(p,temp);
                buf=copy_Bezier_f(Bezier_idx,p,buf);
%                stampa(4,Bezier_idx,buf);
                Bezier_idx = Get_Bezier(Bezier_idx);
                buf=copy_Bezier_f(Bezier_idx,new_p,buf);
%                stampa(4,Bezier_idx,buf);
            else
                buf=copy_Bezier_f(Bezier_idx,p,buf);
%                stampa(5,Bezier_idx,buf);
            end
        end 
      end  %else
    end  %while
end

%funzione di stampa per fare debug
function stampa(id, Bezier_idx, buf)
disp([id,Bezier_idx]);
if (Bezier_idx>0)
   disp(buf(Bezier_idx));
   disp(buf(Bezier_idx).cp)
end

% for i=1:Bezier_idx
%    fprintf('indice %d \n',i);
%    disp(buf(i));
%    disp(buf(i).cp);
% end
end

function bool= det(x1,y1,x2,y2,x3,y3)
 if (y2*(x1-x3)+y1*(x3-x2)+y3*(x2-x1)>0)  
     bool = 1;
 else
     bool = 0;
 end
end

%predispone lo stack a ricevere un nuovo elemento
function Bezier_idx = Get_Bezier(Bezier_idx)
    MAX_FUNCTIONS = 100;
	Bezier_idx = Bezier_idx+1;
	if (Bezier_idx > MAX_FUNCTIONS)
		fprintf(stderr,"Functions stack overflow  \n");
        exit;
    end
end

% Inizializzazione dell'indice dello stack
function [p,Bezier_idx] = Init_Bezier(p)
  p=[];
  Bezier_idx = 0;
end

% Controllo per vedere se lo stack e' vuoto
function bool = Empty_Bezier(Bezier_idx)
    if (Bezier_idx == 0)
        bool=1;
    else
        bool=0;
    end
end

% Viene presa la funzione piu' in alto sullo stack
function [q] = Top_Bezier(p,Bezier_idx)
    q = p(Bezier_idx);
end

% Si decrementa l'indice dello stack 
function  Bezier_idx = Remove_Bezier(Bezier_idx)
    Bezier_idx = Bezier_idx-1;
end

% Si inserisce un elemento nello stack
function buf=copy_Bezier_f(Bezier_idx,q,buf)
% buf(Bezier_idx)=q; %pare che così non vada bene
% procediamo a copiare campo per campo
 buf(Bezier_idx).deg=q.deg;
 buf(Bezier_idx).b=q.b;
 buf(Bezier_idx).a=q.a;
% si copia e trasforma il vettore cp in un vettore riga
 buf(Bezier_idx).cp = q.cp(:)';
end

%clipping a sinistra
function p = bezier_f_clipping_left(p, t)
 beta=(p.b - t)/(p.b - p.a);
 uno_meno_beta=(t - p.a)/(p.b - p.a);
 p.a=t;

 for k=p.deg:-1:1 
  for i=1:k
	p.cp(i)=p.cp(i)*beta+p.cp(i+1)*uno_meno_beta;
  end
 end
end

%clipping a destra
function p = bezier_f_clipping_right(p, t)
 beta=(t - p.a)/(p.b - p.a);
 uno_meno_beta=(p.b - t)/(p.b - p.a);
 p.b=t;

 for k=2:p.deg+1
  for i=p.deg+1:-1:k
     p.cp(i)=p.cp(i)*beta+p.cp(i-1)*uno_meno_beta;
  end
 end
end

%suddivide in due
function [l,p] = bezier_f_subdiv_left(p, t)
 l.deg=p.deg;
 l.a=p.a;
 l.b=t;
 p.a=t;

 beta=(p.b - t)/(p.b - l.a);
 uno_meno_beta=(t - l.a)/(p.b - l.a);

 for k=p.deg:-1:1
    l.cp(p.deg - k + 1)=p.cp(1);
    for i=1:k 
       p.cp(i) = p.cp(i)*beta+p.cp(i+1)*uno_meno_beta;
    end
 end    
 l.cp(p.deg+1)=p.cp(1);
end

