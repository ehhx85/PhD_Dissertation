function [ A ] = get_INPUT( file, FOLDER )

%% Check Input Arguments
if nargin < 2
    path = '';
else
    path = FOLDER.input;
end

if nargin < 1
    file = 'test.ext';
end

%% Define File Directory Info
[folder, name, ext] = fileparts(file);

if isempty(folder)
    A.name = file;
    A.path = fullfile(path, A.name);
else
    A.name = strcat(name,ext);
    A.path = file;
end

[A.folder, A.ID, A.type]  = fileparts(A.path);

end