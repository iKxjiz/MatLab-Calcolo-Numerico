function curv3_frenetframe_plot(cs3name,a,b,np)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv3_frenetframe_plot(cs3name,a,b,np)
%Disegna il Frenet Frame di una curva 3D (T,N,B) utilizzando la terna di
%colori r (tangnte) g (normale) b (binormale)
%cs3name --> nome del file con l'espressione parametrica della curva
%            fino alla derivata seconda
%a,b --> intervallo di definizione
%np --> numero di punti di valutazione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
curv=str2func(cs3name);
t = linspace(a,b,np);
for i=1:np
 [x(i),y(i),z(i),xp(i),yp(i),zp(i),xs(i),ys(i),zs(i)]=curv(t(i));
end

for i=1:np
    td(i)=norm([xp(i),yp(i),zp(i)],2);
    tx(i)=xp(i)/td(i);
    ty(i)=yp(i)/td(i);
    tz(i)=zp(i)/td(i);
end
for i=1:np
    vect3_plot([x(i),y(i),z(i)],[tx(i),ty(i),tz(i)],'r');
%    plot3([x(i),x(i)+tx(i)],[y(i),y(i)+ty(i)],[z(i),z(i)+tz(i)],'g-')
end

%vettore binormale alla curva in ogni punto
for i=1:np
    vect=cross([xp(i),yp(i),zp(i)],[xs(i),ys(i),zs(i)]);
    bd=norm(vect,2);
    bx(i)=vect(1)/bd;
    by(i)=vect(2)/bd;
    bz(i)=vect(3)/bd;
end
for i=1:np
    vect3_plot([x(i),y(i),z(i)],[bx(i),by(i),bz(i)],'b');
%    plot3([x(i),x(i)+bx(i)],[y(i),y(i)+by(i)],[z(i),z(i)+bz(i)],'r-')
end

%vettore normale alla curva in ogni punto
for i=1:np
    vect=cross([bx(i),by(i),bz(i)],[tx(i),ty(i),tz(i)]);
    nd=norm(vect,2);
    nx(i)=vect(1)/nd;
    ny(i)=vect(2)/nd;
    nz(i)=vect(3)/nd;
end
for i=1:np
    vect3_plot([x(i),y(i),z(i)],[nx(i),ny(i),nz(i)],'g');
%    plot3([x(i),x(i)+nx(i)],[y(i),y(i)+ny(i)],[z(i),z(i)+nz(i)],'b')
end

end

