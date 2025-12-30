function mdppBez = curv2_bezier_offset(bezP,d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppBez = curv2_bezier_offset(bezier,d,varargin)
%Determina la curva Bezier a tratti multi-degree offset approssimato
%di una curva 2D di Bezier
%bezP--> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x2
%          bezier.ab  --> intervallo di definizione
%d   --> distanza (positiva o negativa) della curva offset dalla Bezier 
%mdppBez <-- struttura di una curva Bezier a tratti multi-degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%inizializzazioni
n=bezP.deg;
ncp=length(bezP.cp(:,1));
%vettore dei valori estremi della curva di Bezier
extrema=[0];
%struttura fBezier per derivata prima delle funzioni 
%componenti la curva di Bezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
f.cp=n.*(bezP.cp(2:ncp,1)-bezP.cp(1:ncp-1,1))./(f.ab(2)-f.ab(1));
TOL=1.0e-10;
% rootsx = bezier_clipping(f,TOL);
rootsx = lane_riesenfeld(f,TOL);
if (length(rootsx) >= 1)
%     fprintf('Lista delle radici trovate nell''intervallo:\n');
%     fprintf('%22.15e\n',rootsx);
    extrema=[extrema,rootsx];
end
%struttura fBezier
f.deg=bezP.deg-1;
f.ab=bezP.ab;
f.cp=n.*(bezP.cp(2:ncp,2)-bezP.cp(1:ncp-1,2))./(f.ab(2)-f.ab(1));
% rootsy = bezier_clipping(f,TOL);
rootsy = lane_riesenfeld(f,TOL);
if (length(rootsy) >= 1)
%     fprintf('Lista delle radici trovate2 nell''intervallo:\n');
%     fprintf('%22.15e\n',rootsy);
    extrema=[extrema,rootsy];
end

extrema=[extrema,1];
extrema=sort(extrema);

%elimina radici troppo vicine tra loro (vicine meno di 1.0e-2)
for i=length(extrema)-1:-1:1
    if (extrema(i+1)-extrema(i) < 1.0e-2)
        extrema(i)=[];
    end
end

%copia della curva bezP in bez_dx
bez_dx=bezP;

mdppBez.ab=extrema;
ppx=[];
ppy=[];
k=1;

for i=2:length(extrema)-1
  [bez_sx,bez_dx]=decast_subdiv(bez_dx,extrema(i));
  [xo2, yo2] = offsetCurve(bez_sx.cp(:,1), bez_sx.cp(:,2), d);
  if (i==2)
      ppx=xo2(1);
      ppy=yo2(1);
  end
  ppx=[ppx;xo2(2:end)'];
  ppy=[ppy;yo2(2:end)'];
  mdppBez.deg(k)=length(xo2)-1;
  k=k+1;
end

[xo2, yo2] = offsetCurve(bez_dx.cp(:,1), bez_dx.cp(:,2), d);
if (length(extrema)>2)
 ppx=[ppx;xo2(2:end)'];
 ppy=[ppy;yo2(2:end)'];
else
 ppx=[ppx;xo2'];
 ppy=[ppy;yo2'];
end
mdppBez.deg(k)=length(xo2)-1;
k=k+1;

mdppBez.cp(:,1)=ppx;
mdppBez.cp(:,2)=ppy;
end

