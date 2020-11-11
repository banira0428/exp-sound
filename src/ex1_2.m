
[y, Fs] = audioread('../res/example_1.wav');
length(y) / Fs
sound(y, Fs); % 再生
plot(y);
xlabel('sampling number');
ylabel('signal value');
saveas(gcf,'../out/1-2.png');