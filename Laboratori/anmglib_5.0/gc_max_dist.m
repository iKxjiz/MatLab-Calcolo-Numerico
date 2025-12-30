function md = gc_max_dist(pin, p1, pmed, p2, pfin)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function md = gc_max_dist(pin, p1, pmed, p2, pfin)
%Determina la massima distanza dei punti p1, pmed e p2 dalla
%retta passante per pin e pfin
%pin, pfin --> primo e ultimo punto di un tratto di curva 2D
%p1, pmed, p2 --> punti che si vogliono testare per distanza dalla retta
%md <-- massima distanza calcolata
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if ((pin.x==pfin.x) & (pin.y==pfin.y))
    a=1;
    b=-1;
    c=0;
    rq=sqrt(2);
else
    a=pfin.y-pin.y;
    b=pin.x-pfin.x;
    c=pin.y*pfin.x-pin.x*pfin.y;
    rq=sqrt(a*a+b*b);
end
d1=abs(a*p1.x+b*p1.y+c)/rq;

d2=abs(a*pmed.x+b*pmed.y+c)/rq;

d3=abs(a*p2.x+b*p2.y+c)/rq;

md=max([d1,d2,d3]);

end

