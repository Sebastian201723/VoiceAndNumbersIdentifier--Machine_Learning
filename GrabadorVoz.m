% % record some speech (chien):
% r = audiorecorder(22050, 16, 1);
% disp('Start speaking.')
% recordblocking(r, 1.5);
% disp('End of Recording.');
% % Play back the recording.
% play(r);
% % write the recording in a wav file
% filename='v1.wav';
% filename2='v2.wav';
% y  = getaudiodata(r);
% Fs = get(r,'SampleRate');
% audiowrite(filename2, y, Fs);
% [y, Fs] = audioread(filename2);
% filename='sebnovex.wav';
% for n=0:6
%     input=('Presione cualquier tecla para continuar');
%     r1 = audiorecorder(22050, 16, 1);
%     disp('Start speaking.')
%     recordblocking(r1, 1.5);
%     disp('End of Recording.');
%     filename(8)=char(n+48);
%     y1  = getaudiodata(r1);
%     Fs1 = get(r1,'SampleRate');
%     audiowrite(filename, y1, Fs1);
%     [y1, Fs1] = audioread(filename);
% end

for LoopIndex = 1:12
      r1 = audiorecorder(22050, 16, 1);
      disp('Start speaking.')
      recordblocking(r1, 1.5);
      disp('End of Recording.');
      y1  = getaudiodata(r1);
      Fs1 = get(r1,'SampleRate');
      filename = sprintf('LordFaraon%d.wav',LoopIndex);
      audiowrite(filename, y1, Fs1);
      
      fprintf('Saving recording: %s\n ', filename); 
end
    