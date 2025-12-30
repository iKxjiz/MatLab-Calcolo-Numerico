function [vecx,vecy]= c2_rec_val(c2name,tin,pin,tmed,fmed,tfin,pfin,vecx,vecy,tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [vecx,vecy]=c2_rec_val(c2name,tin,pin,tmed,fmed,tfin,pfin,vecx,vecy,tol)
%Valutazione adattiva via suddivisione di una curva 2D
%c2name --> nome del file con l'espressione parametrica della curva
%tin,pin --> valore parametrico e punto curva relativo al primo estremo
%tmed,fmed --> valore parametrico e punto curva relativo al primo estremo
%tfin,pfin --> valore parametrico e punto curva relativo al secondo estremo
%vecx,vecy --> coordinate dei punti valutati fino ad ora
%tol --> tolleranza di valutazione
%vecx,vecy <-- coordinate dei punti in uscita
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(c2name);

n=length(vecx);
t1=tin+(tmed-tin)/2;
[fx,fy]=curv(t1);
f1.x=fx;
f1.y=fy;
t2=tmed+(tfin-tmed)/2;
[fx,fy]=curv(t2);
f2.x=fx;
f2.y=fy;
if (gc_max_dist(pin,f1,fmed,f2,pfin) <= tol)
  vecx(n+1)=pfin.x;
  vecy(n+1)=pfin.y;
else
  pmed.x=fmed.x;
  pmed.y=fmed.y;
  [vecx,vecy]=c2_rec_val(c2name,tin,pin,t1,f1,tmed,pmed,vecx,vecy,tol);
  [vecx,vecy]=c2_rec_val(c2name,tmed,pmed,t2,f2,tfin,pfin,vecx,vecy,tol);
end

end

