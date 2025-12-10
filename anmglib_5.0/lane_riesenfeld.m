function roots = lane_riesenfeld(fun,TOL)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function roots = lane_riesenfeld(fun,TOL)
%Determina gli zeri di una funzione polinomiale data nella base di 
%Bernstein in un intervallo (quello di definizione della base);
%utilizza il metodo denominato in letteratura 'Lane-Riesenfeld'
%fun   --> struttura funzione polinomiale nella base di Bernstein 
%TOL   --> tolleranza
%roots <-- vettore delle radici trovate
%Nota. al momento questa function viene richiamata dalle function
%      della libreria curv2_bezier_offset.m e curv2_ppbezier_offset.m
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  f.deg=fun.deg;
  f.cp=fun.cp;
  f.a=fun.ab(1);
  f.b=fun.ab(2);
  [buf_sr, roots] = root_isolate(f, TOL);
  roots = find_root(buf_sr, roots, TOL);
end

%isolamento di zeri; se uno zero e' multiplo non si riesce a determinare
%un intervallo in cui ci sia una sola variazione di segno, in tal caso la
%routine determina lei lo zero con una convergenza lineare.
function [buf_sr, roots] = root_isolate(f, TOL)
 nr = 0;
 roots = [];
 buf = [];
 buf_sr = [];

 [buf,Bezier_idx]=Init_Bezier(buf);
 Bezier_idx = Get_Bezier(Bezier_idx);
 buf=copy_Bezier_f(Bezier_idx,f,buf);

 [buf_sr,idx]=Init_Bezier(buf_sr);
 
 while (~Empty_Bezier(Bezier_idx))
      p=Top_Bezier(buf,Bezier_idx);   
      num=V_sgn(p);
      if (num==0) 
        Bezier_idx = Remove_Bezier(Bezier_idx);   %zero variazioni di segno
      else 
        if (num==1)  %una variazione di segno
            idx = Get_Bezier(idx);
            buf_sr=copy_Bezier_f(idx,p,buf_sr);
            Bezier_idx = Remove_Bezier(Bezier_idx);
        else 
            if (p.b-p.a<TOL) %Aggiunta al programma originale per
                             %trovare gli zeri in casi eccezionali 
                nr=nr+1;
                roots(nr)=p.a+(p.b-p.a)/2;
                Bezier_idx = Remove_Bezier(Bezier_idx);
            else
                xm=p.a+(p.b-p.a)/2;
                [new_p,p] = bezier_f_subdiv_left(p,xm);
                buf=copy_Bezier_f(Bezier_idx,p,buf);
                Bezier_idx = Get_Bezier(Bezier_idx);
                buf=copy_Bezier_f(Bezier_idx,new_p,buf);
            end
        end %if
      end %if
    end %while
end

%Per ogni intervallo in cui c'e' una variazione di segno,
%viene determinato uno zero.
function roots = find_root(buf_sr,roots,TOL)
 idx=length(buf_sr);
 nr = length(roots);

 while (idx>0)
    p=buf_sr(idx);
    idx=idx-1;
    flag = 1;
    while (flag) 
%       Top_Bezier(p);
      if (abs(p.cp(1))<TOL)  %|C_1| < Epsilon => zero=p.a
          nr=nr+1;
          roots(nr)=p.a;
          flag=0;
      end
      if (abs(p.cp(p.deg+1))<TOL) %|C_n+1| < Epsilon => zero=p.b
          nr=nr+1;
          roots(nr)=p.b;
          flag=0;
      end
      if (flag)
        i=1;  %vengono trovati i 2 coeff. che hanno una variazione di segno
        while (sign(p.cp(i)) == sign(p.cp(i+1)))
           i=i+1;
        end
        alfa=((i-1)*p.cp(i+1)-i*p.cp(i))/((p.deg)*(p.cp(i+1)-p.cp(i)));
        xm=p.a*(1-alfa)+p.b*alfa;
        [new_p,p] = bezier_f_subdiv_left(p,xm);
        if (V_sgn(new_p) ~= 0)
         p = new_p;
        end
      end % if flag
    end  % while flag
  end % while
	
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

%variazioni in segno dei coeff. di Bezier; non e' variazione in senso
%debole, ma nenche in senso forte. E' opportuna per recuperare
%coeff. che sono nulli
function num=V_sgn(f)
 num=0;
 for i=2:f.deg+1
  if (sign(f.cp(i-1)) ~= sign(f.cp(i)))
      num=num+1;
  end
 end
% fprintf('Variazioni di segno = %d\n',num);
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

