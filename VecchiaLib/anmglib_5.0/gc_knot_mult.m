function [t_mult,t_single,nt_s]=gc_knot_mult(g,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [t_mult,t_single,nt_s]=gc_knot_mult(g,t)
%Analiza la partizione nodale e restituisce informazioni
%sui nodi multipli e singoli
%g --> grado della spline/nurbs
%t --> vettore dei knot
%t_mult <-- molteplicita' di ogni nodo distinto
%t_single <-- lista dei nodi distinti
%nt_s <-- numero di knot distinti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(t);
t_mult=[];
t_single=[];
nt_s=0;
m=1;
for i=g+2:nt-g-1
   if (t(i) < t(i+1))
      nt_s=nt_s+1;
      t_mult(nt_s)=m;
      t_single(nt_s)=t(i);
      m=1;
   else
       m=m+1;
   end
end
