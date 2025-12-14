function curv3_bezier_save(filename, bezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv3_bezier_save(filename, bezier)
%Scrive una curva 3D di Bezier su file
%filename --> nome del file di estensione .db
%bezier --> struttura di una curva di Bezier:
%          bezier.deg --> grado della curva
%          bezier.cp  --> lista dei punti di controllo (bezier.deg+1)x3
%          bezier.ab  --> intervallo di definizione
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ncp=bezier.deg+1;
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U\n');
fprintf(fid,'%i\n',bezier.deg);
fprintf(fid,'COORD.C.P.(X,Y,Z)\n');
for i=1:ncp
  fprintf(fid,'%e %e %e\n',bezier.cp(i,1),bezier.cp(i,2),bezier.cp(i,3));
end  
fprintf(fid,'[a,b]\n');
fprintf(fid,'%e\n',bezier.ab(1));
fprintf(fid,'%e\n',bezier.ab(2));

status=fclose(fid);

