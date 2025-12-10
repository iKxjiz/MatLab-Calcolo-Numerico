function main_hilb(n)
%questa funzione vuole confrontare la stima della function cond di MATLAB
%con l'effettivo valore sperimentale del numero di condizione sulla 
%matrice test di Hilbert (function MATLAB hilb) 

if (nargin<1)
    n=5;
end
H=hilb(n);
cH=cond(H);

x=ones(n,1);
b=H*x;
y=H\b;

disp('condizionamento della matrice');
for p=1:5
  db=10^(-p)*rand(n,1);
  dy=H\(b+db);
%indice di condizionamneto della matrice
  cond_sper=norm(dy-x,1)/norm(x,1)*norm(b,1)/norm(db,1);
  fprintf('p=%2d  Kp= %15.7e K= %15.7e\n',p, cond_sper, cH);
end
