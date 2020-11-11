signal_length_sec = 0.6;
sampling_rate = 44100;
A = 0.2;
f = 18000;     

signal_length_pt = signal_length_sec * sampling_rate;
t =  ((1:signal_length_pt) - 1) / sampling_rate;
x = A * sin(2 * pi * f * t)';

sound(x, sampling_rate);

