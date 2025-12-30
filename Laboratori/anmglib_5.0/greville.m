function c=greville(g,t)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function c=greville(g,t)
%Calcola per uno spazio spline dato mediante grado e partizione
%nodale, le ascisse di Greville
%g  --> grado della spline
%t  --> partizione nodale della spline
%c  <-- lista dei punti di Greville
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(t);
mpk=nt-g-1;
for i=1:mpk
%     disp([t(i+1),t(i+2),t(i+3)]);
    c(i)=sum(t(i+1:i+g))./g;
end