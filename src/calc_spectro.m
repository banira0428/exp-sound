function [Pow_X_dB, Pow_X] = calc_spectro(signal, fft_len)

fft_len   = 1024;


m = 1;        % 分割後の何番目か，を表す変数
x_idx_st = 1; % xのどこから分割すればよいか，を表す変数
x_idx_en = x_idx_st + fft_len - 1; % xのどこまでに分割すればよいか，を表す変数

while x_idx_en <= length(signal)
    frame_x(:, m) = [ signal(x_idx_st:x_idx_en); zeros(1024-fft_len, 1) ];

    % 次のループの準備
    m = m + 1;
    x_idx_st = x_idx_st + fft_len;
    x_idx_en = x_idx_st + fft_len - 1;
end

signal = fft(frame_x, fft_len) / fft_len;

Pow_X = abs(signal) .^ 2;
Pow_X((2+fft_len/2):end, :) = [];
Pow_X_dB = 10 * log10(Pow_X);