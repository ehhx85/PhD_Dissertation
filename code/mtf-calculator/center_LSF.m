function [ A ] = center_LSF( A )

%% Gaussian Fit Peak
gauss_fit = fit(A.LSF.bins, A.LSF.intensity_norm, 'gauss1');
A.LSF.gauss = gauss_fit(A.LSF.bins);

%% Center Peak
A.LSF.center_offset = gauss_fit.b1;
A.LSF.bins_centered = A.LSF.bins - A.LSF.center_offset;

%% Determine Limiting Tail Value
A.LSF.lim = min(abs([A.LSF.bins_centered(1), A.LSF.bins_centered(end)])) .* [-1,1];

%% Find Left Tail Index
i_left = length(A.LSF.bins_centered);
while A.LSF.bins_centered(i_left) > A.LSF.lim(1);
    if i_left == 1
        break
    else
        i_left = i_left - 1;
    end
end

%% Find Right Tail Index
i_right = 1;
while A.LSF.bins_centered(i_right) < A.LSF.lim(2);
    if i_right == length(A.LSF.bins_centered)
        break
    else
        i_right = i_right + 1;
    end
end

%% Trim Tails
A.LSF.bins_trim = A.LSF.bins_centered(i_left:i_right);
A.LSF.intensity_trim = A.LSF.intensity_norm(i_left:i_right);

end