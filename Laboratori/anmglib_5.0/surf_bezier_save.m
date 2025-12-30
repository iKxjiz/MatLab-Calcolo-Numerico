function surf_bezier_save(filename, surfbezier)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surf_bezier_save(filename, gu, gv, P, a, b, c, d)
%Scrive una superficie 3D di Bezier su file
%filename --> nome del file di estensione .db
%surfbezier --> struttura di una superficie di Bezier:
%      surfbezier.deguv --> gradi della superficie in u e in v
%      surfbezier.cp --> griglia dei punti di controllo (degu+1)x(degv+1)x3
%      surfbezier.ab  --> intervallo di definizione in u
%      surfbezier.cd  --> intervallo di definizione in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(surfbezier.cp(:,:,1));
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U_V\n');
fprintf(fid,'       %i        %i\n',surfbezier.deguv(1),surfbezier.deguv(2));
fprintf(fid,'COORD.C.P.(X,Y,Z)\n');
for i=1:m
   for j=1:n
     fprintf(fid,'%e %e %e\n',surfbezier.cp(i,j,1),surfbezier.cp(i,j,2),surfbezier.cp(i,j,3));
   end
end  
fprintf(fid,'[a,b]\n');
fprintf(fid,'%e\n',surfbezier.ab(1));
fprintf(fid,'%e\n',surfbezier.ab(2));
fprintf(fid,'[c,d]\n');
fprintf(fid,'%e\n',surfbezier.cd(1));
fprintf(fid,'%e\n',surfbezier.cd(2));

status=fclose(fid);
