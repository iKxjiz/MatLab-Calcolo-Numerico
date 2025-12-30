function mdppBez = curv2_ppbezier_offset(ppbez,d)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppBez = curv2_ppbezier_offset(bezier,d,varargin)
%Determina la curva Bezier a tratti multi-degree offset approssimato
%di una curva 2D di Bezier a tratti
%Attenzione: la curva ppbez in input deve essere C^1.
%ppbez --> struttura di una Bezier a tratti:
%          ppbez.deg --> grado della curva o di ogni tratto
%          ppbez.cp  --> lista dei punti di controllo (nc*ppbez.deg+1) x 2
%          ppbez.ab  --> partizione di [a,b]; nc + 1 elementi
%d     --> distanza (positiva o negativa) della curva offset dalla Bezier 
%mdppBez <-- struttura di una curva Bezier a tratti multi-degree
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nc=length(ppbez.ab)-1;
n=ppbez.deg;

i1=1;
Px=[];

ppx=[];
ppy=[];
k=1;

mdppBez.ab(1)=ppbez.ab(1);
for i=1:nc
    i2=i1+n;
    bezP.deg=n;
    bezP.cp=ppbez.cp(i1:i2,:);
    bezP.ab(1)=ppbez.ab(i);
    bezP.ab(2)=ppbez.ab(i+1);
    %inizializzazioni
    ncp=length(bezP.cp(:,1));
    %vettore dei valori estremi della curva di Bezier
    extrema=bezP.ab(1);
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
    
    extrema=[extrema,bezP.ab(2)];
    extrema=sort(extrema);
    %elimina radici troppo vicine tra loro (vicine meno di 1.0e-2)
    for ii=length(extrema)-1:-1:1
    if (extrema(ii+1)-extrema(ii) < 1.0e-2)
        extrema(ii)=[];
    end
end
    %copia della curva bezP in bez_dx
    bez_dx=bezP;
    for j=2:length(extrema)-1
      [bez_sx,bez_dx]=decast_subdiv(bez_dx,extrema(j));
      [xo2, yo2] = offsetCurve(bez_sx.cp(:,1), bez_sx.cp(:,2), d);
      if (i==1 & j==2)
          ppx=[ppx;xo2(1)];
          ppy=[ppy;yo2(1)];
      end
      ppx=[ppx;xo2(2:end)'];
      ppy=[ppy;yo2(2:end)'];
      mdppBez.deg(k)=length(xo2)-1;
      k=k+1;
    end

    [xo2, yo2] = offsetCurve(bez_dx.cp(:,1), bez_dx.cp(:,2), d);
    if (i==1 & length(extrema) == 2)
      ppx=[ppx;xo2'];
      ppy=[ppy;yo2'];
    else
      ppx=[ppx;xo2(2:end)'];
      ppy=[ppy;yo2(2:end)'];
    end
    mdppBez.deg(k)=length(xo2)-1;
    k=k+1;
    mdppBez.ab=[mdppBez.ab,extrema(2:end)];

  i1=i2;
end
mdppBez.cp(:,1)=ppx';
mdppBez.cp(:,2)=ppy';

end

