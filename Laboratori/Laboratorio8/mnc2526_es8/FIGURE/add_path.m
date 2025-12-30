% add_path.m corretto
scriptPath = fileparts(mfilename('fullpath'));

% Sali di due directory: da mnc2526_es2 -> Laboratorio2 -> MatLab
addpath(fullfile(scriptPath,'..', '..', '..', '..', 'anmglib_5.0'));
addpath(fullfile(scriptPath,'..', '..', '..', '..', 'anmglib_5.0', 'ppbez_code'));