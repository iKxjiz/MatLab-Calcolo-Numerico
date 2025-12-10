function [vecx,vecy]= c2_offset_rec_val(cp2name,tin,pin,tmed,fmed,tfin,pfin,d,vecx,vecy,tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [vecx,vecy]=c2_offset_rec_val(cp2name,tin,pin,tmed,fmed,tfin,pfin,d,vecx,vecy,tol)
%Valutazione adattiva via suddivisione di una curva 2D
%cp2name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata prima
%tin,pin --> valore parametrico e punto curva relativo al primo estremo
%tmed,fmed --> valore parametrico e punto curva relativo al primo estremo
%tfin,pfin --> valore parametrico e punto curva relativo al secondo estremo
%d --> distanza positiva o negativa della curva offset dalla curva data
%vecx,vecy --> coordinate dei punti gia' valutati
%tol --> tolleranza di valutazione
%vecx,vecy <-- coordinate dei punti in uscita
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(cp2name);

n=length(vecx);
t1=tin+(tmed-tin)/2;
[fx,fy,fpx,fpy]=curv(t1);
vnT=norm([fpx,fpy],2);
vTx=fpx/vnT;
vTy=fpy/vnT;
vTortx=vTy;
vTorty=-vTx;
f1.x=fx+d*vTortx;
f1.y=fy+d*vTorty;

t2=tmed+(tfin-tmed)/2; 
[fx,fy,fpx,fpy]=curv(t2);
vnT=norm([fpx,fpy],2);
vTx=fpx/vnT;
vTy=fpy/vnT;
vTortx=vTy;
vTorty=-vTx;
f2.x=fx+d*vTortx;
f2.y=fy+d*vTorty;

if (gc_max_dist(pin,f1,fmed,f2,pfin) <= tol)
  vecx(n+1)=pfin.x;
  vecy(n+1)=pfin.y;
else
  pmed.x=fmed.x;
  pmed.y=fmed.y;
  [vecx,vecy]=c2_offset_rec_val(cp2name,tin,pin,t1,f1,tmed,pmed,d,vecx,vecy,tol);
  [vecx,vecy]=c2_offset_rec_val(cp2name,tmed,pmed,t2,f2,tfin,pfin,d,vecx,vecy,tol);
end

end

