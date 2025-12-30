function [y]=lsolve(L,b)
%Input:
%L : matrice triangolare inferiore
%b : termine noto
%Output:
%y : soluzione
y=b;
y(1)=y(1)/L(1,1);
n=length(y);
for i=2:n
  for j=1:i-1
    y(i)=y(i)-L(i,j)*y(j);
  end
  y(i)=y(i)/L(i,i);
end
