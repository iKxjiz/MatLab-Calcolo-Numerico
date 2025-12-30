function [bez_sx,bez_dx]=decast_subdiv(bezier,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bez_sx,bez_dx]=decast_subdiv(bezier,x)
%Suddivide una curva nD di Bezier definita in bezier.ab 
%di punti di controllo bezier.cp nel punto x in bezier.ab
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo
%          bezier.ab  --> intervallo di definizione
%x   --> punto in [a,b] in cui suddividere
%bez_sx <-- struttura della Bezier sinistra risultante:
%          bez_sx.deg --> grado della curva
%          bez_sx.cp  --> lista dei punti di controllo
%          bez_sx.ab  --> intervallo di definizione [a x]
%bez_dx <-- struttura della Bezier sinistra risultante:
%          bez_dx.deg --> grado della curva
%          bez_dx.cp  --> lista dei punti di controllo
%          bez_dx.ab  --> intervallo di definizione [x b]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Questa function esiste anche con il nome bezier_subdiv

xx=(x-bezier.ab(1))/(bezier.ab(2)-bezier.ab(1));

m=length(x);

 bez_sx.cp(1,:)=bezier.cp(1,:);
 bez_dx.cp=bezier.cp;
 d1=xx;
 d2=1.0-xx;
 for j=1:bezier.deg
  for i=1:bezier.deg-j+1
   bez_dx.cp(i,:)=d1.*bez_dx.cp(i+1,:)+d2.*bez_dx.cp(i,:);
  end
  bez_sx.cp(j+1,:)=bez_dx.cp(1,:);
 end
 %imposto i campi mancanti delle curve sinistra e destra
 bez_sx.ab=[bezier.ab(1) x];
 bez_dx.ab=[x bezier.ab(2)];
 bez_sx.deg=length(bez_sx.cp(:,1))-1;
 bez_dx.deg=length(bez_dx.cp(:,1))-1;

%    c(1)  c(2)  c(3) ...               c(n)
%    c2(1) c2(2) c2(3) ...              c2(n) --> c1(1):=c2(1)
%j=1 c2(1) c2(2)                c2(n-1)       --> c1(2):=c2(1)
%j=2 c2(1) c2(2)        c2(n-2)               --> c1(3):=c2(1)
%...
%j=g c2(1)                                    --> c1(g+1):=c2(1)

end
