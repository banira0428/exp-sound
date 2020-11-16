% JAN_PLOT_WAVEFORMS.M
% 音声データを時間波形としてプロットするスクリプト

signal_length_sec = 1.0;   % Signal length [sec]
sampling_rate = 16000;

t_n = linspace(0, signal_length_sec, size(Pow_X_dB)(2)+1);
t_n(end) = [];

f_k = linspace(0, sampling_rate/2, size(Pow_X_dB)(1)+1);
f_k(end) = [];


figure(1);
subplot(2, 3, 1);
imagesc(t_n, f_k, Jan_Goo_PowX_dB(:,1))
set(gca, 'YDir', 'normal');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

subplot(2, 3, 2);
imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
title('Chk 1');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

subplot(2, 3, 3);
imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
title('Par 1');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

subplot(2, 3, 4);
imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
title('Goo 2');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

subplot(2, 3, 5);
imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
title('Chk 2');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');

subplot(2, 3, 6);
imagesc(t_n, f_k, Pow_X_dB)
set(gca, 'YDir', 'normal');
title('Par 2');
caxis([-70 -20])
c = colorbar;
title(c,'Power[dB]')
ylabel('Frequency[Hz]');
xlabel('Time[s]');


saveas(gcf,'../out/4-4.png');
