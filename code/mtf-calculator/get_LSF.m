function [ A ] = get_LSF( A )

%% Calculate Line Spread Function
A.LSF.bins = A.ESF.bins;

A.LSF.intensity = diff([A.ESF.average;A.ESF.average(end)]);
A.LSF.intensity(isnan(A.LSF.intensity)) = 0;

%% Define Tail Cutoff to Isolate Edge Peak
i_cutoff = floor(length(A.LSF.bins) * 0.1);
i_trim = [i_cutoff : length(A.LSF.bins) - i_cutoff];

%% Calculate Intensity Limits
min_intensity = min(A.LSF.intensity(i_trim));
max_intensity = max(A.LSF.intensity(i_trim));

%% Calculate Peak Max Value
if abs(min_intensity) > abs(max_intensity);
    norm_val = min_intensity;
else
    norm_val = max_intensity;
end

%% Normalize Line Spread Function
A.LSF.intensity_norm = A.LSF.intensity ./ norm_val;

end