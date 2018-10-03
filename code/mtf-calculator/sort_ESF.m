function [ A ] = sort_ESF( A )

%% Sort Angle Aligned Edge Spread Functions
[A.ESF.sorted_position, index] = sort(A.ESF.pos_align);
A.ESF.sorted_intensity = A.ESF.intensity(index);

%% Rebin Aligned Edge Spread Functions
[A.ESF.counts,~] = histcounts(A.ESF.sorted_position, [A.ESF.bins(1)-1;A.ESF.bins]);
A.ESF.counts = A.ESF.counts';

%% Calculate Average Edge Spread Function
k = 0;
for i = 1 : length(A.ESF.counts)

    sum = 0;
    for j = 1 : A.ESF.counts(i)
        k = k + 1;
        sum = sum + A.ESF.sorted_intensity(k);
    end
    
    A.ESF.average(i,1) = sum / A.ESF.counts(i);
    
end

end