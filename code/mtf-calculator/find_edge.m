function [ A ] = find_edge( A )

%% Apply Canny Edge Detector
A.Z.edge = edge(A.Z.crop, 'canny');

%% Apply Hough Transform
[H,T,R] = hough(A.Z.edge);

A.EDGE.H = H;
A.EDGE.theta = T;
A.EDGE.rho = R;

%% Find Hough Peaks and Resulting Angle
P = houghpeaks(H,1,'threshold',ceil(0.95*max(H(:))));
A.EDGE.angle = P(2);

end