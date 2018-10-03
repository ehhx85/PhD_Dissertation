function [ A ] = set_scale( A, pixel_size )

%% Check Input Arguments
if nargin < 2
    A.pixel = 1;
else
    A.pixel = pixel_size;
end

%% Convert Index to Physical Distance
A.X.lim_d = A.X.lim .* A.pixel;
A.Y.lim_d = A.Y.lim .* A.pixel;

A.X.dist = A.X.index .* A.pixel;
A.Y.dist = A.Y.index .* A.pixel;

end