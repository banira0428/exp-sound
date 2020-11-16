% JAN_CALC_POWERSPECS.M
% load_wavefilesで読み込んだ音声データからパワースペクトルを計算するプログラム

% Prepare
fft_len = 800;      % Why 16384?  -> see Chapter 3   

% Process: Goo
[Jan_Goo_PowX_dB, Jan_Goo_PowX] = calc_spectro(Jan_Goo(:, 1:2), fft_len);

% Process: Chk
[Jan_Chk_PowX_dB, Jan_Chk_PowX] = calc_spectro(Jan_Chk(:, 1:2), fft_len);

% Process: Par
[Jan_Par_PowX_dB, Jan_Par_PowX] = calc_spectro(Jan_Par(:, 1:2), fft_len);

