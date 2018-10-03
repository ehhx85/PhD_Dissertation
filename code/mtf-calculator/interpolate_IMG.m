function [ A ] = interpolate_IMG( A, vertical )

%% Define Oversampling Gain
A.gain = 10;
A.EDGE.vertical = vertical;

%% Vertical Edge Interpolation
if vertical
    base_index = [1:length(A.y.index)];

    A.x.interp = interp(A.x.index, A.gain);
    A.y.interp = A.y.index;

    A.x.interp_d = [0:length(A.x.interp) - 1]' .* A.pixel ./ A.gain;
    A.y.interp_d = [0:length(A.y.interp) - 1]' .* A.pixel;
    
    for i = base_index
        A.Z.interp(i,:) = interp(A.Z.crop(i,:), A.gain);
    end

%% Horizontal Edge Interpolation
else
    base_index = [1:length(A.x.index)];

    A.x.interp = A.x.index;
    A.y.interp = interp(A.y.index, A.gain);A.x.index;

    A.x.interp_d = [0:length(A.x.interp) - 1]' .* A.pixel;    
    A.y.interp_d = [0:length(A.y.interp) - 1]' .* A.pixel ./ A.gain;
    
    for i = base_index
        A.Z.interp(:,i) = interp(A.Z.crop(:,i), A.gain);
    end
    
end

end