function [ A ] = get_ESF( A )

%% Define Arrays
A.ESF.position = [];
A.ESF.intensity = [];
A.ESF.pos_align = [];

%% Vertical Edge Process
if A.EDGE.vertical
    A.ESF.lim = A.x.lim_d;
    A.ESF.bins = A.x.interp_d;

    for i = [1:length(A.y.index)]
    
        i_position = A.x.interp_d(:);
        i_intensity = A.Z.interp(i,:)';
    
        A.ESF.position = [A.ESF.position; i_position];
        A.ESF.intensity = [A.ESF.intensity; i_intensity];
    
        pos_shift =  tand(90-A.EDGE.angle) .* i .* A.pixel;
        pos_adjusted = A.x.interp_d(:) - pos_shift;
    
        A.ESF.pos_align = [A.ESF.pos_align; pos_adjusted ];

    end

%% Horizontal Edge Process    
else
    A.ESF.lim = A.y.lim_d;
    A.ESF.bins = A.y.interp_d;

    for i = [1:length(A.x.index)]
    
        i_position = A.y.interp_d(:);
        i_intensity = A.Z.interp(:,i);
    
        A.ESF.position = [A.ESF.position; i_position];
        A.ESF.intensity = [A.ESF.intensity; i_intensity];
    
        pos_shift =  tand(A.EDGE.angle) .* i .* A.pixel;
        pos_adjusted = A.y.interp_d(:) - pos_shift;
    
        A.ESF.pos_align = [A.ESF.pos_align; pos_adjusted ];

    end
    
end

%% Balance Alignment Shift About Edge Center
A.ESF.pos_align = A.ESF.pos_align + (pos_shift/2);

end