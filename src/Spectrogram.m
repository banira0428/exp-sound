%% Generate sinusoidal (pure tone) waveform
signal_length_sec = 1.0;   % Signal length [sec]
sampling_rate = 16000;     % Sampling frequency [Hz]
A = 0.5;                   % Amplitude
f = 1000;                  % Frequency of pure tone [Hz]

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;

x = A * sin(2 * pi * f * t)';     % "x" is a sinusoidal waveform.

%% フレーム化処理（基本）
frame_len = 800;   % パラメータ：フレーム長
fft_len   = 1024;

m = 1;        % 分割後の何番目か，を表す変数
x_idx_st = 1; % xのどこから分割すればよいか，を表す変数
x_idx_en = x_idx_st + frame_len - 1; % xのどこまでに分割すればよいか，を表す変数

while x_idx_en <= length(x)
    frame_x(:, m) = [ x(x_idx_st:x_idx_en); zeros(1024-frame_len, 1) ];

    % 次のループの準備
    m = m + 1;
    x_idx_st = x_idx_st + frame_len;
    x_idx_en = x_idx_st + frame_len - 1;
end

X = fft(frame_x, fft_len) / fft_len;

Pow_X = abs(X) .^ 2;
Pow_X((2+fft_len/2):end, :) = [];
Pow_X_dB = 10 * log10(Pow_X);

size(Pow_X_dB)

t_n = linspace(0, signal_length_sec, size(Pow_X_dB)(2)+1);
t_n(end) = [];

f_k = linspace(0, sampling_rate/2, size(Pow_X_dB)(1)+1);
f_k(end) = [];

imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

saveas(gcf,'../out/3-1.png');




