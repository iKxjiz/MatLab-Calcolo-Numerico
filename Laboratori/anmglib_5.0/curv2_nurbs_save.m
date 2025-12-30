function curv2_nurbs_save(filename, nurbs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv2_nurbs_save(filename, nurbs)
%Scrive una curva 2D nurbs su file
%filename --> nome del file di estensione .db
%nurbs --> struttura formata da 4 campi:
%          nurbs.deg --> grado della curva
%          nurbs.cp  --> lista dei punti di controllo (ncp)x2
%          nurbs.knot  --> vettore dei nodi (ncp)
%          nurbs.w --> lista dei pesi (ncp+nurbs.deg+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(nurbs.knot);
ncp=nt-nurbs.deg-1;
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U\n');
fprintf(fid,'%i\n',nurbs.deg);
fprintf(fid,'N.C.P.\n');
fprintf(fid,'%i\n',ncp);
fprintf(fid,'N.KNOTS\n');
fprintf(fid,'%i\n',nt);

fprintf(fid,'COORD.C.P.(X,Y,W)\n');
for i=1:ncp
  fprintf(fid,'%e %e %e\n',nurbs.cp(i,1),nurbs.cp(i,2),nurbs.w(i));
end  
fprintf(fid,'KNOTS\n');
for i=1:nt
  fprintf(fid,'%e\n',nurbs.knot(i));
end  

status=fclose(fid);

