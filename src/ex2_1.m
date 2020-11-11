signal_length_sec = 0.6;
sampling_rate = 16000;
A = 0.2;
f = 8;     

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;
x = A * sin(2 * pi * f * t)';

% sound(x, sampling_rate);

plot(t, x);
xlabel('t[s]');
ylabel('x');
saveas(gcf,'../out/2-1-1.png');

X = fft(x) / length(x);
XPow = abs(X) .^ 2;
stem(XPow, 'o-');
ylabel('power');
xlabel('frequency number');
saveas(gcf,'../out/2-1-2.png');
xlim([1 10])
saveas(gcf,'../out/2-1-3.png');

