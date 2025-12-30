function curv3_spline_save(filename, spline)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv3_spline_save(filename, spline)
%Scrive una curva 3D spline su file
%filename --> nome del file di estensione .db
%spline --> struttura formata di una curva spline:
%          spline.deg --> grado della curva
%          spline.cp  --> lista dei punti di controllo (ncp)x3 
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

fprintf(fid,'COORD.C.P.(X,Y,Z)\n');
for i=1:ncp
  fprintf(fid,'%e %e %e\n',spline.cp(i,1),spline.cp(i,2),spline.cp(i,3));
end  
fprintf(fid,'KNOTS\n');
for i=1:nt
  fprintf(fid,'%e\n',t(i));
end  

status=fclose(fid);

