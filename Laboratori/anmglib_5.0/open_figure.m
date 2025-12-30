function id=open_figure(id)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function ido=open_figure(id)
%Apertura di una finestra grafica e setting di alcuni parametri
%id --> identificatore della finestra (opzionale)
%id <-- identificatore della finestra (opzionale)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if (nargin==0 && nargout==1)
  id=figure();
end
if (nargin==0 && nargout==0)
  figure();
end
if (nargin==1)
  figure(id);
end

hold on;
axis equal;

