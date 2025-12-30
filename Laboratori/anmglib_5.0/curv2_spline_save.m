function curv2_spline_save(filename, spline)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv2_spline_save(filename, spline)
%Scrive una curva 2D spline su file
%filename --> nome del file di estensione .db
%spline --> struttura di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x2 
%          spline.knot  --> vettore dei nodi (ncp+g+1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nt=length(spline.knot);
ncp=nt-spline.deg-1;
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U\n');
fprintf(fid,'%i\n',spline.deg);
fprintf(fid,'N.C.P.\n');
fprintf(fid,'%i\n',ncp);
fprintf(fid,'N.KNOTS\n');
fprintf(fid,'%i\n',nt);

fprintf(fid,'COORD.C.P.(X,Y)\n');
for i=1:ncp
  fprintf(fid,'%e %e\n',spline.cp(i,1),spline.cp(i,2));
end  
fprintf(fid,'KNOTS\n');
for i=1:nt
  fprintf(fid,'%e\n',spline.knot(i));
end  

status=fclose(fid);

