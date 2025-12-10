function [x]=usolve(U,y)
%Input:
%U : matrice triangolare superiore
%y : termine noto
%Output:
%x : soluzione
x=y;
n=length(x);
for i=n:-1:2
  x(i)=x(i)/U(i,i);
  for j=1:i-1
    x(j)=x(j)-U(j,i)*x(i);
  end
end
x(1)=x(1)/U(1,1);
