
% 下準備
clear;
Jan_load_wavefiles;
Jan_calc_powerspecs;

result_string_table = {'Goo', 'Chk', 'Par'};

rec = audiorecorder(16000, 16, 1);
fft_len = 16384;

for i = 1:10 

    Jan_Goo_PowX_dB_Rep = sum(Jan_Goo_PowX_dB, 2) / size(Jan_Goo_PowX_dB)(2);
    Jan_Chk_PowX_dB_Rep = sum(Jan_Chk_PowX_dB, 2) / size(Jan_Chk_PowX_dB)(2);
    Jan_Par_PowX_dB_Rep = sum(Jan_Par_PowX_dB, 2) / size(Jan_Par_PowX_dB)(2);

    disp('3'); pause(1); disp('2'); pause(1); disp('1'); pause(1); disp('Go!'); % count down
    recordblocking(rec, 0.6);
    x = getaudiodata(rec);

    [PowX_dB, PowX] = calc_powerspec(x, fft_len);

    Dist(1) = sqrt( sum( (PowX_dB(:,1) - Jan_Goo_PowX_dB_Rep ) .^2 ) );
    Dist(2) = sqrt( sum( (PowX_dB(:,1) - Jan_Chk_PowX_dB_Rep ) .^2 ) );
    Dist(3) = sqrt( sum( (PowX_dB(:,1) - Jan_Par_PowX_dB_Rep ) .^2 ) );
    disp(Dist); % for debug

    %% 5-2. Select the pattern that has a minimum distance
    [~, idx] = min(Dist);

    if idx == 1
        Jan_Goo_PowX_dB = [Jan_Goo_PowX_dB PowX_dB(:,1)];
    end
    if idx == 2
        Jan_Goo_PowX_dB = [Jan_Chk_PowX_dB PowX_dB(:,1)];
    end
    if idx == 3
        Jan_Goo_PowX_dB = [Jan_Par_PowX_dB PowX_dB(:,1)];
    end

    %% 6. Display the result stiring!
    disp(result_string_table{idx});

end