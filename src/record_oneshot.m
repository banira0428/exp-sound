function record_oneshot(wav_length, wav_filename)
% RECORD_ONESHOT  �J�E���g�_�E����������^�����Ďw�肵���t�@�C���ɏ����o���֐�
%   RECORD_ONESHOT(wav_length, wav_filename)
%       wav_length�b�̉��f�[�^��^�����āCwav_filename�Ƃ������O�̃t�@�C���ɉ��f�[�^��ۑ�����

% Initialize audiorecorder
rec = audiorecorder(16000, 16, 1);  % 16000 Hz, 16 bit, 1 channel

% Count down
disp('3'); pause(1); disp('2'); pause(1); disp('1'); pause(1);
disp('Go!');

% Start recording
recordblocking(rec, wav_length);

% Get data and save it.
x = getaudiodata(rec);
audiowrite(wav_filename, x, rec.SampleRate);

% Debug
plot(x);
sound(x, rec.SampleRate);

end