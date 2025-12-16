%***************************************************
% script sexpression.m
% Valutazione dell'espressione ((1+x)-1)/x
% con x numero finito e determinare E_ALG;
% utilizzare il programma sconv_dec2bin.m per
% determinare se i valori x utilizzati hanno una
% rappresentazione esatta in base 2 a 53 cifre
%***************************************************
clear
clc

%assegna un valore alla x e scommentare
x=[100.0023, 30, 10, 1.0, 0.1, 0.01, 1e-8, 1e-16, 1e-20, 1e-30];

for elem = x
  %calcolo espressione
  y=((1+elem)-1)/elem;
  %stampa risultato e test
  fprintf(' x                      y\n');
  fprintf('%22.15e %22.15e\n\n',elem,y);
  fprintf('ErrAlg = %22.15e\n',abs((y-1))/1);
  if (y==1.0)
    fprintf('calcolo esatto\n');
  else
    fprintf('calcolo errato\n');
  end
end

%% Espanso e Commentato

% Precisione macchina
U = eps/2 % circa 1.11e-16

x = [30, 10, 1.0, 0.1, 0.01, 1e-8, 1e-16, 1e-20, 1e-30];

fprintf('%-15s %-22s %-22s %-22s %-15s\n', 'x', 'y calcolato', '|y-1|', 'E_Alg stimato', 'Stato');
fprintf('%s\n', repmat('-', 1, 90));

for elem = x
  % Calcolo dei passaggi intermedi per vedere l'errore
  somma = 1 + elem;           % Primo errore qui (ε₁)
  diff = somma - 1;           % Cancellazione catastrofica per x piccolo
  y = diff / elem;            % Risultato finale

  % Errore relativo effettivo
  err_effettivo = abs(y - 1);

  % Stima dell'errore algoritmico (dalla formula teorica)
  % ε₁ ≈ U per x grandi, ma cresce per x piccoli
  % Stima semplificata: E_Alg ≈ |1/x| * U + 3U
  E_alg_stimato = abs(1/elem) * U + 3*U;

  % Determina se il calcolo è accurato
  if (abs(y - 1) < 1e-14)
    stato = 'ESATTO';
  else
    stato = 'ERRATO';
  end

  fprintf('%-15.3e %-22.15e %-22.15e %-22.15e %-15s\n', ...
    elem, y, err_effettivo, E_alg_stimato, stato);
end