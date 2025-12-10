function mdppbezier=curv2_bezier2svg(bezier,tol)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function mdppbezier=curv2_bezier2svg(bezier,tol)
%Converte una curva 2D di Bezier di grado > 3 in una curva di
%Bézier a tratti di grado 3
%bezier --> struttura di una curva bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (ncp)x2 
%          bezier.ab  --> estremi dell'intervallo di definizione
%tol    --> tolleranza con cui approssimare la curva 2D
%mdppbezier  <-- struttura della curva 2D di Bezier a tratti 
%                multi-degree
%Nota: ncp = bezier.deg + 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


a=bezier.ab(1);
b=bezier.ab(2);
m=2;
nptv=20;
MaxErr=tol;

while (MaxErr >= tol)
    m=m+1;
    %parametri equispaziati
    t=linspace(a,b,m);
    xyp=decast_valder(bezier,1,t);
    %punti e derivate della curva da interpolare
    Q=[xyp(1,:,1)',xyp(1,:,2)'];
    Q1=[xyp(2,:,1)',xyp(2,:,2)'];
    
    %chiama funzione per interpolare a tratti
    ppP=curv2_ppbezierCC1_interp_der(Q,Q1,t);
    
    %valutazione in punti equispaziati per test sull'errore
    nptv=nptv+20;
    tv=linspace(a,b,nptv);
    Pxy=ppbezier_val(ppP,tv);
    Qxy=decast_val(bezier,tv);
    
    %calcola la distanza euclidea fra i punti della curva test
    %e della curva di Bézier a tratti interpolante e considera
    %la distanza massima
    MaxErr=max(vecnorm((Pxy-Qxy)'));
    % fprintf('MaxErr: %e\n',MaxErr);
end

mdppbezier=curv2_ppbezier2mdppbezier(ppP);
end

