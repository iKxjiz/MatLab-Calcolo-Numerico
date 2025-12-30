function curv2_mdppbezier_save(filename, P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv3_mdppbezier_save(filename, P)
%Scrive una curva 3D di Bezier a tratti su file
%filename --> nome del file di estensione .db
%P --> struttura formata da tre campi:
%      P.deg --> lista dei gradi della curva
%      P.cp  --> lista dei punti di controllo ncp x 3
%      P.ab .--> partizione di [a,b]; nc + 1 elementi
%Nota: nc = numero dei tratti
%      ncp = numero dei punti di controllo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ncp=length(P.cp(:,1));
nc=length(P.ab)-1;
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'NC\n');
fprintf(fid,'%i\n',nc);
fprintf(fid,'DEGREE\n');
for i=1:nc
  fprintf(fid,'%i\n',P.deg(i));
end
fprintf(fid,'COORD.C.P.(X,Y,Z)\n');
for i=1:ncp
  fprintf(fid,'%e %e\n',P.cp(i,1),P.cp(i,2),P.cp(i,3));
end  
fprintf(fid,'KNOTS\n');
for i=1:nc+1
  fprintf(fid,'%e\n',P.ab(i));
end
status=fclose(fid);

