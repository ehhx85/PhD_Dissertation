function [ A ] = get_IMG( INPUT )

%% Check Input Arguments
if nargin < 1
    path = 'default.tif';
else
    path = INPUT.path;
end

A.pixel = 0;

%% Load Image Data From File
data = imread(path);
data = flipud(data);

%% Define Image Sizing Variables
A.Z.lim = [min(min(data)), max(max(data))];
A.Z.raw = data;

A.X.lim = [1, size(data,2)];
A.Y.lim = [1, size(data,1)];

A.X.index = [A.X.lim(1) : A.X.lim(2)]';
A.Y.index = [A.Y.lim(1) : A.Y.lim(2)]';

end