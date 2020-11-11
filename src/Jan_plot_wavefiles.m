% JAN_PLOT_WAVEFORMS.M
% 音声データを時間波形としてプロットするスクリプト

%% Plot by subplot
% Time axis
t =  ((1:length(Jan_Goo(:,1))) - 1) / Fs;
% Plot figures
figure(1);
subplot(2, 3, 1);
  plot(t, Jan_Goo(:, 1));
  title('Goo 1');
  xlabel('Time [s]'); ylabel('Signal value');
subplot(2, 3, 2);
  plot(t, Jan_Chk(:, 1));
  title('Cho-Ki 1');
  xlabel('Time [s]'); ylabel('Signal value');
subplot(2, 3, 3);
  plot(t, Jan_Par(:, 1));
  title('Par 1');
  xlabel('Time [s]'); ylabel('Signal value');
subplot(2, 3, 4);
  plot(t, Jan_Goo(:, 2));
  title('Goo 2');
  xlabel('Time [s]'); ylabel('Signal value');
subplot(2, 3, 5);
  plot(t, Jan_Chk(:, 2));
  title('Cho-Ki 2');
  xlabel('Time [s]'); ylabel('Signal value');
subplot(2, 3, 6);
  plot(t, Jan_Par(:, 2));
  title('Par 2');
  xlabel('Time [s]'); ylabel('Signal value');