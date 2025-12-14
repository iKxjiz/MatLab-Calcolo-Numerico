function [bs,bsp]=bernst_valder(g,x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function [bs,bsp]=bernst_valder(g,x)
%Valuta le funzioni base di Bernstein di grado g e le loro derivate
%prime nei punti x in [0,1]
%g  --> grado
%x  --> punti in [0,1] in cui valutare
%bs <-- matrice delle funzioni di Bernstein nei punti
%bsp<-- matrice delle funzioni di Bernstein derivate prima nei punti
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m=length(x);
n=g+1;
bs=zeros(m,n);
bsp=zeros(m,n);
for k=1:m
 l=n;
 bs(k,l)=1.0;
 if g==1
     bsp(k,1)=-1;
     bsp(k,2)=1;
 end
 d1=x(k);
 d2=1.0-x(k);
 for i=1:g
   temp=0.0;
   for j=l:n
     bs(k,j-1)=d2.*bs(k,j)+temp;
     temp=d1.*bs(k,j);
   end
   bs(k,n)=temp;
   l=l-1;
   % calcolo dei valori di derivata prima   
   if i==g-1
     temp=0;
     for j=l:n
       bsp(k,j-1)=temp-g.*bs(k,j);
       temp=g.*bs(k,j);
     end
     bsp(k,n)=temp;
   end
% fine calcolo derivata si continua con i valori   

end
end