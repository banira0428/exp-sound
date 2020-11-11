signal_length_sec = 0.6;
sampling_rate = 16000;
A = 0.2;
f = 8;     

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;
x = A * sin(2 * pi * f * t)';

% sound(x, sampling_rate);

X = fft(x) / length(x);
XPow = abs(X) .^ 2;
f_k = linspace(0, sampling_rate/2, length(XPow)/2+1);
XPow((2+length(XPow)/2):end) = [];
XPow_dB = 10 * log10(XPow);
plot(f_k, XPow_dB);
xlim([0 20])
xlabel('Frequency [Hz]');
ylabel('power [db]');
saveas(gcf,'../out/2-2-1.png');

plot(f_k, XPow);
xlim([0 20])
xlabel('Frequency [Hz]');
ylabel('power');
saveas(gcf,'../out/2-2-2.png');

