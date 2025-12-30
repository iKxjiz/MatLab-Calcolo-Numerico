function bs=bernst_val(g,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function bs=bernst_val(g,x)
%Valuta le funzioni base di Bernstein di grado g nei punti x in [0,1]
%g  --> grado
%x  --> punti in [0,1] in cui valutare
%bs <-- matrice dei valori delle funzioni di Bernstein nei punti x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(x);
n=g+1;
bs=zeros(m,n);
for k=1:m
 bs(k,n)=1.0;
 d1=x(k);
 d2=1.0-x(k);
 for i=n:-1:2
   temp=0.0;
% B_{j,i}(t) = t * B_{j-1,i-1}(t) + (1-t) * B_{j,i-1}(t) j=0,..,n
% B_{j-1,i}(t) = t * B_{j-1,i-1}(t) + (1-t) * B_{j,i-1}(t) j=n,..,0
   for j=i:n
     bs(k,j-1)= temp + d2.*bs(k,j);
     temp=d1.*bs(k,j);
   end
   bs(k,n)=temp;
  end
end
%Formula ricorrente 
%B_{j,i}(t) = t * B_{j-1,i-1}(t) + (1-t) * B_{j,i-1}(t) j=0,..,n
%
%B_{j-1,i-1} B_{j,i-1} B_{j+1,i-1}    j=0,..,i-1
%          \  |      \ |
% -->   ...  B_{j,i}   B_{j+1,i}      j=0,..,i
%
%Implementazione in un array
%B(j-1) = t * B(j-1) + (1-t) * B(j) j=n,..,0
%
%B(j-1) B(j) B(j+1)   j=n,..,n-i
%     |  /   | /
%B(j-1) B(j)  ...     j=n,..,n-i+1


  

