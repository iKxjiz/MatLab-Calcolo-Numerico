%****************************************************
%function fidiff.m
%Approssimazione del valore della derivata della
%funzione exp(x) mediante rapporto incrementale
%al diminuire di h
%****************************************************
function fidiff(x)
if nargin<1
  x=1;
end

% valore esatto della derivata di exp(x)
fp = exp(x);

% Pre-allocazione dei vettori
RErr = zeros(15, 1);

n=15;
h = logspace(-(n-1),0,n)'; % vettore colonna dei passi
fprintf(' h            fp           fpfd     AErr      RErr\n');
for k=n:-1:1
  fpfd = (exp(x+h(k)) - exp(x))/h(k); %calcolo del rapporto incrementale
  AErr(k) = abs(fpfd - fp); % Absolute Error
  RErr(k) = abs((fpfd - fp)/fp); % Relative Error
  fprintf('%8.1e %12.5f %12.5f %9.2e %9.2e\n',h(k),fp,fpfd,AErr(k),RErr(k));
  % stampa degli addendi che potrebbero provocare cancellazione numerica
  fprintf('--> %3d %8.1e %9.2e\n %22.15e \n %22.15e\n',k,h(k),RErr(k),exp(x+h(k)),exp(x));
end

%%grafico del Relative Error in scala logaritmica
open_figure(1);
loglog(h,RErr,'o-','LineWidth',1.5);
grid on;
xlabel('Stepsize h');
ylabel('Relative error');
