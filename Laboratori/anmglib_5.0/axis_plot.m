function axis_plot(lax1,afs,lax2,lax3)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function axis_plot(lax1,afs,lax2,lax3)
%Disegna il sistema di assi cartesiani 2D o 3D
%lax1, lax2, lax3 --> lunghezza degli assi (se tutti i parametri
%     vengono omessi si assumono di lunghezza 1; se lax2 e lax3 
%     vengono omessi si considerano uguali a lax1)
%afs --> fattore di scala per dimensionare le frecce degli assi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<1
    lax1=1;
    afs=0.25*lax1/sqrt(lax1);
    lax2=lax1;
    lax3=lax1;
end
if nargin==1
%Scelta euristica di sc per il disegno della freccia degli assi coordinati
  lax2=lax1;
  lax3=lax1;
  if(lax1>1)
   afs=0.25*sqrt(lax1);
  else
   afs=0.25*lax1/sqrt(lax1);
  end
end
if nargin==2
  lax2=lax1;
  lax3=lax1;
end
if nargin==3
  lax3=lax1;
end


O=[0,0,0];
X=[lax1,0,0];
Y=[0,lax2,0];
Z=[0,0,lax3];
vect3_plot(O,X,'r', 1.5, 'k', [0.5,0.5,0.5], 6, afs);
vect3_plot(O,Y,'g', 1.5, 'k', [0.5,0.5,0.5], 6, afs);
vect3_plot(O,Z,'b', 1.5, 'k', [0.5,0.5,0.5], 6, afs);

end
