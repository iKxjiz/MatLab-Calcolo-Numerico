function surf_nurbs_save(filename, surfnurbs)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function surf_nurbs_save(filename, surfnurbs)
%Scrive una superficie 3D nurbs su file
%filename --> nome del file di estensione .db
%surfnurbs --> struttura di una superficie spline:
%      surfnurbs.deguv --> grado della superficie in u e in v
%      surfnurbs.cp --> griglia dei punti di controllo (ncpu)x(ncpv)x3
%      surfnurbs.ku  --> vettore dei knot in u
%      surfnurbs.kv  --> vettore dei knot in v
%      surfnurbs.w --> griglia dei pesi (ncpu)x(ncpv)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[m,n]=size(surfnurbs.cp(:,:,1));
ntu=length(surfnurbs.ku);
ntv=length(surfnurbs.kv);
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'DEGREE_U_V\n');
fprintf(fid,'       %i        %i\n',surfnurbs.deguv(1),surfnurbs.deguv(2));
fprintf(fid,'N.C.P._U_V\n');
fprintf(fid,'       %i        %i\n',m,n);
fprintf(fid,'KNOTS_U_V\n');
fprintf(fid,'       %i        %i\n',ntu,ntv);
fprintf(fid,'COORD.C.P.(X,Y,Z,W)\n');
for i=1:m
    for j=1:n
        fprintf(fid,'%e %e %e %e\n',surfnurbs.cp(i,j,1),surfnurbs.cp(i,j,2),surfnurbs.cp(i,j,3),W(i,j));
    end
end  
fprintf(fid,'KNOTS_U\n');
for i=1:ntu
   fprintf(fid,'%e\n',surfnurbs.ku(i));
end
fprintf(fid,'KNOTS_V\n');
for i=1:ntv
   fprintf(fid,'%e\n',surfnurbs.kv(i));
end
status=fclose(fid);
