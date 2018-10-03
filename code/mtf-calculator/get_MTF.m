function [ A ] = get_MTF( A )

%% Set Fourier Space Parameters
n = length(A.LSF.bins_trim);
Fs = 2 / A.pixel * A.gain; % (lp/mm)
f = Fs * [ 0 : 1/n : 1/2 ]';

%% Apply Fast Fourier Transform
Y = fft(A.LSF.intensity_window,n);
P = abs(Y/n);
P = P / max(P);
P = P(1:length(f));

A.MTF.x = f;
A.MTF.y = P;

%% Fit Spline Curve to MTF
myfit = fit(f,P,'smoothingspline');
ffit = [f(1):0.01:f(end)]';
Pfit = myfit(ffit);

%% Calculate Frequency of Threshold
i = 1;
MTF_y = 1;

while MTF_y > 0.1
    MTF_x = ffit(i);
    MTF_y = interp1(ffit,Pfit,MTF_x);
    i = i + 1;
end

%% Convert Frequency to Spatial Value
A.MTF.point = [MTF_x,MTF_y];
A.MTF.res = 1 / (2 * MTF_x) * 1e3;
A.MTF.lim = [0,A.MTF.point(1) * 2.5];

end

