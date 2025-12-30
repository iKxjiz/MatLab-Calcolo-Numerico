function [IP1P2,t1,t2]=curv2_intersect(P1,P2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [IP1P2,t1,t2]=curv2_intersect(P1,P2)
%Determina i punti di intersezione delle curve P1 e P2 e i loro parametri.
%Questa function prende in input due curve in forma parametrica di tipo
%Bézier, ppBézier, mdppBézier, spline e nurbs.
%Se viene chiamata con un solo argomento (una sola curva), vengono
%calcolate le auto intersezioni e i loro parametri.
%P1, P2 --> strutture delle curve in input dei tipi dopra elencati
%IP1P2  <-- struttura 2xn contenente le n intersezioni trovate
%t1, t2 <-- array contenenti i parametri dei punti di intersezione
%           rispettivamente per la prima e seconda curva
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

np=-100;
Ps=P1;
if (isfield(Ps,'w')) 
    flag=5;
    elseif (isfield(Ps,'knot')) flag=4;
    elseif (length(Ps.ab) == 2) flag=1;
    elseif ((length(Ps.ab)-1)*Ps.deg+1 == length(Ps.cp(:,1))) flag=2;
    else flag=3;
end
tP1=[];
tP2=[];
switch flag
    case 1
        P1xy = curv2_bezier_plot(Ps,np);
%         a1=Ps.ab(1); b1=Ps.ab(2);
        tP1=linspace(Ps.ab(1),Ps.ab(2),abs(np));
    case 2
        P1xy = curv2_ppbezier_plot(Ps,np);
%         a1=Ps.ab(1); b1=Ps.ab(end);
        nc=length(Ps.ab)-1;
        for i=1:nc
            tP1=[tP1,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
        end
    case 3
        P1xy = curv2_mdppbezier_plot(Ps,np);
%         a1=Ps.ab(1); b1=Ps.ab(end);
        nc=length(Ps.ab)-1;
        for i=1:nc
            tP1=[tP1,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
        end
    case 4
        P1xy = curv2_spline_plot(Ps,np);
%         a1=Ps.knot(1); b1=Ps.knot(end);
        [~,tP1]=gc_mesh(Ps.deg,Ps.knot,abs(np));
    case 5
        P1xy = curv2_nurbs_plot(Ps,np);
%         a1=Ps.knot(1); b1=Ps.knot(end);
        [~,tP1]=gc_mesh(Ps.deg,Ps.knot,abs(np));
end

t1=[];
t2=[];
IP1P2=[];

if (nargin > 1)
    Ps=P2;
    if (isfield(Ps,'w')) 
        flag=5;
        elseif (isfield(Ps,'knot')) flag=4;
        elseif (length(Ps.ab) == 2) flag=1;
        elseif ((length(Ps.ab)-1)*Ps.deg+1 == length(Ps.cp(:,1))) flag=2;
        else flag=3;
    end
    switch flag
        case 1
            P2xy = curv2_bezier_plot(Ps,np);
%             a2=Ps.ab(1); b2=Ps.ab(2);
            tP2=linspace(Ps.ab(1),Ps.ab(2),abs(np));
        case 2
            P2xy = curv2_ppbezier_plot(Ps,np);
%             a2=Ps.ab(1); b2=Ps.ab(end);
            nc=length(Ps.ab)-1;
            for i=1:nc
                tP2=[tP2,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
            end
        case 3
            P2xy = curv2_mdppbezier_plot(Ps,np);
%             a2=Ps.ab(1); b2=Ps.ab(end);
            nc=length(Ps.ab)-1;
            for i=1:nc
                tP2=[tP2,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
            end
        case 4
            P2xy = curv2_spline_plot(Ps,np);
%             a2=Ps.knot(1); b2=Ps.knot(end);
            [~,tP2]=gc_mesh(Ps.deg,Ps.knot,abs(np));
        case 5
            P2xy = curv2_nurbs_plot(Ps,np);
%             a2=Ps.knot(1); b2=Ps.knot(end);
            [~,tP2]=gc_mesh(Ps.deg,Ps.knot,abs(np));
    end
    
    IP1P2 = InterX(P1xy',P2xy');
    
    for i=1:length(IP1P2(1,:))
        [s,k]=gc_dist3(IP1P2(1,i),IP1P2(2,i),P1xy(:,1),P1xy(:,2));
        t1(i)=tP1(k(1));
        [s,k]=gc_dist3(IP1P2(1,i),IP1P2(2,i),P2xy(:,1),P2xy(:,2));
        t2(i)=tP2(k(1));
    end
else
    IP1P2 = InterX(P1xy');
    for i=1:length(IP1P2(1,:))
        [s,k]=gc_dist3(IP1P2(1,i),IP1P2(2,i),P1xy(:,1),P1xy(:,2));
        t1(i)=tP1(k(1));
        t2(i)=tP1(k(2));
    end
end

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

