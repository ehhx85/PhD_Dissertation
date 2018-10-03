function [ A ] = set_roi( A, roi_limits )

%% Check Input Arguments
if nargin < 2
    roi = zeros(1,4);
else
    roi = roi_limits;
end

%% Set Region of Interest Coordinates
if roi(1) <= 0
    A.x.lim(1) = A.X.lim(1);
else
    A.x.lim(1) = roi(1);
end

if (roi(2) == 0) || (roi(2) > A.X.lim(2))
    A.x.lim(2) = A.X.lim(2);
else
    A.x.lim(2) = roi(2);
end

if roi(3) <= 0
    A.y.lim(1) = A.Y.lim(1);
else
    A.y.lim(1) = roi(3);
end

if (roi(4) == 0) || (roi(4) > A.Y.lim(2))
    A.y.lim(2) = A.Y.lim(2);
else
    A.y.lim(2) = roi(4);
end

%% Create Index and Spatial Distance Arrays
A.x.index = [A.x.lim(1) : A.x.lim(2)]';
A.y.index = [A.y.lim(1) : A.y.lim(2)]';

A.x.dist = (A.x.index - A.x.index(1)) .* A.pixel;
A.y.dist = (A.y.index - A.y.index(1)) .* A.pixel;

A.x.lim_d = [A.x.dist(1), A.x.dist(end)];
A.y.lim_d = [A.y.dist(1), A.y.dist(end)];

%% Create ROI Outline Rectangle for Overlay
A.ROI.index = [
    [A.x.lim(1), A.y.lim(1)];
    [A.x.lim(1), A.y.lim(2)];
    [A.x.lim(2), A.y.lim(2)];
    [A.x.lim(2), A.y.lim(1)];
	[A.x.lim(1), A.y.lim(1)];
];

A.ROI.dist = [
    [A.x.lim_d(1), A.y.lim_d(1)];
    [A.x.lim_d(1), A.y.lim_d(2)];
    [A.x.lim_d(2), A.y.lim_d(2)];
    [A.x.lim_d(2), A.y.lim_d(1)];
	[A.x.lim_d(1), A.y.lim_d(1)];
];

A.ROI.dist = A.ROI.index .* A.pixel;

A.ROI.z = ones(1,length(A.ROI.index)) * A.Z.lim(2) * 1.01;

end