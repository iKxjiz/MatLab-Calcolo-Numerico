function curv2_mdppbezier_save(filename, mdppbez)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%function curv2_mdppbezier_save(filename, P)
%Scrive una curva 2D di Bezier a tratti su file
%filename --> nome del file di estensione .db
%mdppbez  --> struttura formata da tre campi:
%             mdppbez.deg --> lista dei gradi della curva
%             mdppbez.cp  --> lista dei punti di controllo ncp x 2
%             mdppbez.ab  --> partizione di [a,b]; nc+1 elementi
%Nota: nc = numero dei tratti
%      ncp = numero dei punti di controllo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ncp=length(mdppbez.cp(:,1));
nc=length(mdppbez.ab)-1;
fid=fopen(filename,'w');
fprintf(fid,'FILENAME:%s\n',filename);
fprintf(fid,'NC\n');
fprintf(fid,'%i\n',nc);
fprintf(fid,'DEGREE\n');
for i=1:nc
  fprintf(fid,'%i\n',mdppbez.deg(i));
end
fprintf(fid,'COORD.C.P.(X,Y)\n');
for i=1:ncp
  fprintf(fid,'%e %e\n',mdppbez.cp(i,1),mdppbez.cp(i,2));
end  
fprintf(fid,'KNOTS\n');
for i=1:nc+1
  fprintf(fid,'%e\n',mdppbez.ab(i));
end
status=fclose(fid);

