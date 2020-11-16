 disp('***** Say kakoi *****')
 record_oneshot(1, '../wav/kakoi.wav');

 disp('***** Say ikoka *****')
 record_oneshot(1, '../wav/ikoka.wav');

[Kakoi(:, 1), Fs] = audioread('../wav/kakoi.wav');
Ikoka(:, 1) = audioread('../wav/ikoka.wav');

fft_len = 16384;      % Why 16384?  -> see Chapter 3

% Process: Goo
[Kakoi_PowX_dB, Kakoi_PowX] = calc_powerspec(Kakoi(:, 1), fft_len);
[Ikoka_PowX_dB, Ikoka_PowX] = calc_powerspec(Ikoka(:, 1), fft_len);

% Prepare
f_k = linspace(0, Fs/2, fft_len/2+1);  % Fsはload_wavefilesで読み込まれて�?��はず�?サンプリング周波数 (16,000Hz)

% Plot: Goo
subplot(3, 1, 1);
  plot(f_k, Ikoka_PowX_dB);
  xlabel('Frequency [Hz]'); ylabel('Power [dB]');
  legend('Ikoka');
  ylim([-120 -20]);
  
% Plot: Goo
subplot(3, 1, 2);
  plot(f_k, Kakoi_PowX_dB);
  xlabel('Frequency [Hz]'); ylabel('Power [dB]');
  legend('Kakoi');
  ylim([-120 -20]);


saveas(gcf,'../out/5-3.png');


sqrt( sum( ( Kakoi_PowX_dB(:,1) - Ikoka_PowX_dB(:,1)).^2 ) )
