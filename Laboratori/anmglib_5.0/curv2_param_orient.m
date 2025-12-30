function or=curv2_param_orient(curvname,a,b)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function or=curv2_param_orient(curvname,a,b)
%Determina l'orientamento (orario/antiorario) di una curva 2D chiusa
%curvname --> nome del file con l'espressione parametrica della curva
%a,b --> intervallo di definizione
%or  <-- -1 antiorario; +1 orario
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

curv=str2func(curvname);
nQ = 100;
t = linspace(a,b,nQ);
Q=zeros(nQ,2);
for i=1:nQ
 [Q(i,1),Q(i,2)]=curv(t(i));
end

%definiamo un punto esterno alla curva, per es. un vertice 
%del bounding box
R=min(Q);
%oppure un punto interno alla curva, per es. il baricentro
%R=mean(Q);
%calcolo i vettori v generati come Q-R (tranne l'ultimo che sarà uguale al 
%primo essendo la curva chiusa; si tratta di un vettore di vettori)
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

