function [P,tpar] = curv2_nearest_point(x0,y0,curvP)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [P,tpar] = curv2_nearest_point(x0,y0,curvP)
%Determina il punto più vicino (in norma euclidea) di una curva 2D
%ad un punto dato e il valore parametrico della curva.
%La curva in input può essere di uno qualunque dei seguenti 5 tipi:
%Bézier, ppBézier, mdppBézier, spline e nurbs.
%x0,y0  --> punto 2D
%curvP  --> struttura di una curva 2D di uno dei tipi sopra elencati
%P      <-- punto 2D della curva più vicino al punto dato
%tpar   <-- parametro della curva in corrispondenza di P
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

np=-100;
if (isfield(curvP,'w')) 
    flag=5;
elseif (isfield(curvP,'knot')) flag=4;
elseif (length(curvP.ab) == 2) flag=1;
elseif ((length(curvP.ab)-1)*curvP.deg+1 == length(curvP.cp(:,1))) flag=2;
else flag=3;
end
t=[];
switch flag
    case 1
        P1xy = curv2_bezier_plot(curvP,np);
        a1=curvP.ab(1); b1=curvP.ab(2);
        t=linspace(a1,b1,abs(np));
    case 2
        P1xy = curv2_ppbezier_plot(curvP,np);
        a1=curvP.ab(1); b1=curvP.ab(end);
        nc=length(curvP.ab)-1;
        for i=1:nc
            t=[t,linspace(curvP.ab(i),curvP.ab(i+1),abs(np))];
        end
    case 3
        P1xy = curv2_mdppbezier_plot(curvP,np);
        a1=curvP.ab(1); b1=curvP.ab(end);
        for i=1:nc
            t=[t,linspace(curvP.ab(i),curvP.ab(i+1),abs(np))];
        end
    case 4
        P1xy = curv2_spline_plot(curvP,np);
        a1=curvP.knot(1); b1=curvP.knot(end);
        [~,t]=gc_mesh(curvP.deg,Ps.knot,abs(np));
    case 5
        P1xy = curv2_nurbs_plot(curvP,np);
        a1=curvP.knot(1); b1=curvP.knot(end);
        [~,t]=gc_mesh(curvP.deg,Ps.knot,abs(np));
end

[s,k]=gc_dist3(x0,y0,P1xy(:,1),P1xy(:,2));
%k contiene gli indici dei tre punti della curva più vicini al punto dato
%cerchiamo il più vicino ancora fra np punti campionati fra questi tre
%appena trovati
np=20;
ab=sort(t(k));
t=linspace(ab(1),ab(3),np);
switch flag
    case 1
        P1xy = decast_val(curvP,t);
    case 2
        P1xy = ppdecast_val(curvP,t);
    case 3
        P1xy = mdppdecast_val(curvP,t);
    case 4
        P1xy = deboor_val(curvP,t);
    case 5
        P1xy = nurbs_val(curvP,t);
end
[s,k]=gc_dist1(x0,y0,P1xy(:,1),P1xy(:,2));
tpar=t(k(1));
P=[P1xy(k(1),1),P1xy(k(1),2)];

end

function [vval,vind]=gc_dist1(x0,y0,x,y)
%determina il punto (x(i),y(i)) della lista di punti (x,y)
%piu' vicino a (x0,y0) in norma euclidea;
%ritorna la distanza minore (vval) e il suo indice 
%nella lista dei punti (vind)
    vdist=sqrt((x0-x).^2+(y0-y).^2);
    [vval,vind]=min(vdist);
end

function [vval,vind]=gc_dist3(x0,y0,x,y)
%determina i tre punti (x(i),y(i)) della lista (x,y)
%piu' vicini a (x0,y0) in norma euclidea;
%ritorna le tre distanze minori (vettore vval) e i loro indici 
%nella lista dei punti (vettore vind)
    vdist=sqrt((x0-x).^2+(y0-y).^2);
    [val,ind]=min(vdist);
    vval(1)=val;
    vind(1)=ind;
    vdist(ind)=realmax;
    [val,ind]=min(vdist);
    vval(2)=val;
    vind(2)=ind;
    vdist(ind)=realmax;
    [val,ind]=min(vdist);
    vval(3)=val;
    vind(3)=ind;
end
