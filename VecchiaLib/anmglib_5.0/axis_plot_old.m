function axis_plot_old(lax,afs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function axis_plot(lax,afs)
%Disegna il sistema di assi cartesiani 2D o 3D
%lax --> lunghezza degli assi (se il parametro viene omesso si
%        assume la lunghezza 1)
%afs --> fattore di scala per dimensionare le frecce degli assi
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if nargin<1
    lax=1;
    afs=0.25*lax/sqrt(lax);
end
if nargin==1
%Scelta euristica di sc per il disegno della freccia degli assi coordinati
  if(lax>1)
   afs=0.25*sqrt(lax);
  else
   afs=0.25*lax/sqrt(lax);
  end
end

O=[0,0,0];
X=[lax,0,0];
Y=[0,lax,0];
Z=[0,0,lax];
vect3_plot(O,X,'r', 1.5, 'k', [0.5,0.5,0.5], 6, afs);
vect3_plot(O,Y,'g', 1.5, 'k', [0.5,0.5,0.5], 6, afs);
vect3_plot(O,Z,'b', 1.5, 'k', [0.5,0.5,0.5], 6, afs);

end
