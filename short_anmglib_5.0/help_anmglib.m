function help_anmglib(str)
if ispc
    ll=ls(['../anmglib_5.0/*',str,'*']);
    disp(ll);
else
    ll=ls(['../anmglib_5.0/*',str,'*']);
    ll=erase(ll,'../anmglib_5.0/');
    disp(ll);
%     fprintf('%s\n',ll);
end
    


