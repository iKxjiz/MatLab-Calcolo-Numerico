function surf_spline_save(filename, surfspline)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surf_spline_save(filename, surfspline)
%Scrive una superficie 3D spline su file
%filename --> nome del file di estensione .db
%surfspline --> struttura di una superficie spline:
%      surfspline.deguv --> grado della superficie in u e in v
%      surfspline.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfspline.ku  --> vettore dei knot in u
%      surfspline.kv  --> vettore dei knot in v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(surfspline.cp(:,:,1));
ntu=length(surfspline.ku);
ntv=length(surfspline.kv);
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U_V\n');
fprintf(fid,'       %i        %i\n',surfspline.deguv(1),surfspline.deguv(2));
fprintf(fid,'N.C.P._U_V\n');
fprintf(fid,'       %i        %i\n',m,n);
fprintf(fid,'KNOTS_U_V\n');
fprintf(fid,'       %i        %i\n',ntu,ntv);
fprintf(fid,'COORD.C.P.(X,Y,Z)\n');
for i=1:m
    for j=1:n
        fprintf(fid,'%e %e %e\n',surfspline.cp(i,j,1),surfspline.cp(i,j,2),surfspline.cp(i,j,3));
    end
end  
fprintf(fid,'KNOTS_U\n');
for i=1:ntu
   fprintf(fid,'%e\n',surfspline.ku(i));
end
fprintf(fid,'KNOTS_V\n');
for i=1:ntv
   fprintf(fid,'%e\n',surfspline.kv(i));
end
status=fclose(fid);
