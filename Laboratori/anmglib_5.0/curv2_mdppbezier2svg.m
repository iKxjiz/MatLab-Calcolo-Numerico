function mdppbezQ = curv2_mdppbezier2svg(mdppbezP,tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppbezQ = curv2_mdppbezier2svg(mdppbezP,tol)
%Converte una curva 2D di Bezier a tratti multi-degree in una curva
%di Bézier a tratti multi-degree con gradi <= 3 (svg curve)
%mdppbezP  --> struttura di una Bezier a tratti multi-degree:
%              mdppbezP.deg --> lista dei gradi della curva
%              mdppbezP.cp  --> lista dei punti di controllo
%              mdppbezP.ab  --> partizione di [a,b]; nc + 1 elementi
%tol       --> tolleranza con cui approssimare la curva 2D
%mdppbezQ  <-- struttura della curva 2D di Bezier a tratti 
%                multi-degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%se la curva in input non ha la struttura di una Bézier a tratti
%multi-degree la converto
if (length(mdppbezP.deg)==1 && length(mdppbezP.ab>2))
  mdppbezP=curv2_ppbezier2mdppbezier(mdppbezP);
end

%numero di tratti della curva
nc=length(mdppbezP.ab)-1;

i1=1;
mdppbezQ.deg=[];
mdppbezQ.cp=mdppbezP.cp(1,:);
mdppbezQ.ab=mdppbezP.ab(1);
for i=1:nc
  i2=i1+mdppbezP.deg(i);
  bezier.deg=mdppbezP.deg(i);
  bezier.cp=mdppbezP.cp(i1:i2,:);
  ncp=i2-i1+1;
  bezier.ab(1)=mdppbezP.ab(i);
  bezier.ab(2)=mdppbezP.ab(i+1);
  nQ=length(mdppbezQ.ab);
  if (bezier.deg > 3)
     mdppbezT = curv2_bezier2svg(bezier,tol);
     nT=length(mdppbezT.ab);
     mcp=length(mdppbezT.cp(:,1));
     mdppbezQ.deg=[mdppbezQ.deg,mdppbezT.deg];
     mdppbezQ.cp=[mdppbezQ.cp;mdppbezT.cp(2:mcp,:)];
     mdppbezQ.ab=[mdppbezQ.ab,mdppbezQ.ab(nQ)+mdppbezT.ab(2:nT)-mdppbezT.ab(1)];
  else
     mdppbezQ.deg=[mdppbezQ.deg,bezier.deg];
     mdppbezQ.cp=[mdppbezQ.cp;bezier.cp(2:ncp,:)];
     mdppbezQ.ab=[mdppbezQ.ab,mdppbezQ.ab(nQ)+bezier.ab(2)-bezier.ab(1)];
  end
  i1=i2;
end

end

