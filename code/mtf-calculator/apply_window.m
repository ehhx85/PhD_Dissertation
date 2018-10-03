function [ A ] = apply_window( A )

%% Define Window Size
window_width = 0.5;
window_n = floor(length(A.LSF.bins_trim) * window_width);

%% Create Window
A.LSF.window = tukeywin(window_n, 0.5);

%% Pad Window and Trim
left_padding = floor(length(A.LSF.bins_trim) * (1-window_width) / 2);
A.LSF.window = padarray(A.LSF.window,[left_padding,0],'pre');

right_padding = length(A.LSF.bins_trim) - length(A.LSF.window);
A.LSF.window = padarray(A.LSF.window,[right_padding,0],'post');

%% Apply Window
A.LSF.intensity_window = A.LSF.intensity_trim .* A.LSF.window;

end