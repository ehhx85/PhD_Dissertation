function [ A ] = get_OUTPUT( FOLDER, INPUT )

%% Check Input Arguments
if nargin < 2
    ID = 'test';
else
    ID = INPUT.ID;
end

if nargin < 1
    folder = '';
else
    folder = FOLDER.output;
end

%% Define Output Directory Info
A.folder = folder;
A.ID = ID;
A.type = '.png';

end