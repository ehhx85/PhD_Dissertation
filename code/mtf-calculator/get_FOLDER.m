function [ A ] = get_FOLDER( ~ )

%% Get Base File Path
this.file = fullfile(mfilename('fullpath'));
this.folder = fileparts(this.file);

%% Define Root Directory
A.main = fileparts(this.folder);

%% Define Sub Directories
A.functions = this.folder;
A.input = fullfile(A.main, 'inputs');
A.output = fullfile(A.main, 'outputs');

end