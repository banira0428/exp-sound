%% Generate sinusoidal (pure tone) waveform
signal_length_sec = 0.6;   % Signal length [sec]
sampling_rate = 16000;     % Sampling frequency [Hz]
A = 0.2;                   % Amplitude
f = 10;                    % Frequency of pure tone [Hz]

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;
x = A * sin(2 * pi * f * t)';     % "x" is a sinusoidal waveform.

sound(x, sampling_rate);

% plot(t, x);
% xlabel('time');
% ylabel('loud');
% saveas(gcf,'plot.png');

% X = fft(x) / length(x);
% XPow = abs(X) .^ 2;
% f_k = linspace(0, sampling_rate/2, length(XPow)/2+1);
% XPow((2+length(XPow)/2):end) = [];
% XPow_dB = 10 * log10(XPow);
% plot(f_k, XPow_dB);
% xlim([0 10])
% xlabel('Frequency [Hz]');
% saveas(gcf,'pow.png');



