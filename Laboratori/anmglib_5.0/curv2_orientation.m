function or=curv2_orientation(Ps)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function or=curv2_orientation(Ps)
%Determina l'orientazione della curva chiusa Ps.
%Questa function prende in input una curva Ps in forma parametrica di 
%tipo Bézier, ppBézier, mdppBézier, spline e nurbs.
%P  --> struttura della curve in input dei tipi sopra elencati
%or <-- -1 antiorario; +1 orario
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

np=-100;
if (isfield(Ps,'w')) 
    flag=5;
    elseif (isfield(Ps,'knot')) flag=4;
    elseif (length(Ps.ab) == 2) flag=1;
    elseif ((length(Ps.ab)-1)*Ps.deg+1 == length(Ps.cp(:,1))) flag=2;
    else flag=3;
end
% tP1=[];
switch flag
    case 1
        Q = curv2_bezier_plot(Ps,np);
%         tP1=linspace(Ps.ab(1),Ps.ab(2),abs(np));
    case 2
        Q = curv2_ppbezier_plot(Ps,np);
%         nc=length(Ps.ab)-1;
%         for i=1:nc
%             tP1=[tP1,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
%         end
    case 3
        Q = curv2_mdppbezier_plot(Ps,np);
%         nc=length(Ps.ab)-1;
%         for i=1:nc
%             tP1=[tP1,linspace(Ps.ab(i),Ps.ab(i+1),abs(np))];
%         end
    case 4
        Q = curv2_spline_plot(Ps,np);
%         [~,tP1]=gc_mesh(Ps.deg,Ps.knot,abs(np));
    case 5
        Q = curv2_nurbs_plot(Ps,np);
%         [~,tP1]=gc_mesh(Ps.deg,Ps.knot,abs(np));
end

%definiamo un punto esterno alla curva, 
%per es. un vertice del bounding box
R=min(Q);
%oppure un punto interno alla curva, per es. il baricentro
%R=mean(Q);

nQ=length(Q(:,1));
%calcolo i vettori v generati come Q-R (tranne l'ultimo che sarà uguale al 
%primo, essendo la curva chiusa; si tratta di un vettore di vettori)
%e calcolo dei segmenti della curva (w)
v=Q(1:nQ-1,:)-R;
w=Q(1:nQ-1,:)-Q(2:nQ,:);
%calcolo la norma 2 di questi vettori
normv=vecnorm(v',2);
normw=vecnorm(w',2);
%calcolo dell'angolo fra questi vettori; si tratta di un angolo senza segno
sum=0.0;
for i=1:nQ-2
  alfa=acos(v(i,:)*w(i,:)'/(normv(i)*normw(i)));
  %componente z del prodotto vettoriale dei vettori 3D (wx,wy,0) e
  %(vx,vy,0)
  temp=w(i,1)*v(i,2)-w(i,2)*v(i,1);
  %se la componente z>0 allora sto girando in senso antiorario, se 
  %z<0 sto girando in senso orario e nei due casi sommo o sottraggo il
  %valore dell'angolo
  if (temp>0)
      sum=sum+alfa;
  end
  %if temp==0 non faccio nulla
  if (temp<0)
      sum=sum-alfa;
  end
end
%test conclusivo
if (sum>0)
    or=-1;
else
    or=+1;
end

end