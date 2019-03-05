% clear all
% clc
% sx = audioread('LordFaraon9.wav');
% Fs1 = 22050;
% hplayer = audioplayer(sx, Fs1);
% play(hplayer);
% figure(1)
% plot(sx)
function [yvector]=preproc(Fs1,sx)
%% CALCULO DEL ESPECTRO DE POTENCIA
Res = 10; % Resolucion en frecuencia = 10 Hz
Npuntos = 2^nextpow2(Fs1/2/Res);
w = hanning(Npuntos);
[P,F] = pwelch(sx,w,Npuntos/2,Npuntos,Fs1);
% figure
% semilogx(F,10*log10(P))
% axis tight 
% grid on
% xlabel(['Frequency in ' 'Hz'])
% ylabel('Powe Spectrum(Db)')
% grid on
% axis tight
% ax = axis;
% axis([F(2) ax(2:4)])

%% SUBMUESTREO Y SOBREMUESTREO
Fs = Fs1/3; 
y = downsample(sx,3); %Submuestramos a 7500 Hz aproximadamente.
Npuntosds = 2^nextpow2(Fs/2/Res);
wds = hanning(Npuntosds);
[Pds,Fds] = pwelch(y,wds,Npuntosds/2,Npuntosds,Fs);
% 
% figure(2)
% semilogx(F,10*log10(P),Fds,10*log10(Pds));
% legend('Signal sampled at 22050 Hz', 'Downsampled signal, Fs = 5512 Hz');
% 
% xlabel(['Frequency in ' 'Hz'])
% ylabel('Power Spectrum (dB)')
% grid on
% axis tight
% ax= axis;
% axis([F(2) ax(2:4)])

%% SE DISEÑA UN FILTRO PASABAJO PARA QUITAR COMPONENTES QUE NO SEAN DEL 
%RANGO DE LA SEÑAL DE VOZ.
Fp = 3e3; % Passband frequency in Hz
Fst = 3.4e3; % Stopband frequency in Hz
Ap = 1; % Passband ripple in dB
Ast = 95; % Stopband attenuation in dB
df = designfilt('lowpassfir','PassbandFrequency',Fp,...
'StopbandFrequency',Fst,'PassbandRipple',Ap,...
'StopbandAttenuation',Ast,'SampleRate',Fs);

%% COMPENSACION POR RETARDO DE GRUPO
% Este metodo sirve en retardos constantes (Filtros FIR)
D = mean(grpdelay(df)); % filter delay
ylp = filter(df,[y; zeros(D,1)]); % Se agregan ceros
ylp = ylp(D+1:end);
%Look at the spectrum of the lowpass filtered signal.
[Plp,Flp] = pwelch(ylp,w,Npuntos/2,Npuntos,Fs);

% figure
% semilogx(F,10*log10(P),Flp,10*log10(Plp));
% legend('Espectro original', 'Espectro con filtro pasa bajas');
% %hold on
% %semilogx(F2*E1,Y2,'vr')
% xlabel(['Frequency in ' 'Hz'])
% ylabel('Power Spectrum (dB)')
% grid on
% axis tight
% ax= axis;
% axis([F(2) ax(2:4)])


%% HACEMOS UN FILTRADO A PASABANDA EN 60 HZ PARA QUITAR EL RUIDO DEL 
% AMBIENTE.
dpb = designfilt('bandstopiir','PassbandFrequency1',55,...
'StopbandFrequency1',58,'StopbandFrequency2',62,...
'PassbandFrequency2',65,'PassbandRipple1',0.01,...
'StopbandAttenuation',60,'PassbandRipple2',0.01,...
'SampleRate',Fs,'DesignMethod','ellip');


ydpb = filtfilt(dpb,ylp); %COMPENSACION POR RETARDO

% hplayer = audioplayer(ydpb, Fs);
% play(hplayer);

%% 3. FILTRO DE PRE-ENFASIS
% MU = 1
B = [1 -0.95];
yem = filter(B,1,ydpb);
% figure(3)
% plot(yem)

% hplayer = audioplayer(yem, Fs);
% play(hplayer);

%% 4. REMOCION DE SILENCIOS
% https://www.lawebdelprogramador.com/foros/Matlab/1496738-eliminar-los-ceros-de-una-senal-de-audio-en-matlab.html

len = length(ydpb);% length del vector
d=max(abs(ydpb));
ydpb=ydpb/d;
avg_e = sum(ydpb.*ydpb)/len; %promedio se�al entera
THRES = 0.02;
yvector = [0];
        for i = 1:400:len-400 % cada 10ms
        seg = ydpb(i:i+399);% segmentos
        e = sum(seg.*seg)/400; % promedio de cada segmento
                if( e> THRES*avg_e) % si el promedio energ�tico es mayor que la se�al
                        %completa por el valor umbral
                        yvector=[yvector;seg(1:end)];% almacena en y sino es eliminado como espacio en blanco
                end
        end
        
%  figure(4)
%  plot(yvector)
% hplayer = audioplayer(yvector, Fs);
% play(hplayer);
%% SUBMUESTREO Y SOBREMUESTREO 

%yvector = interp(yvector,3); % upsampling
%yvector = upsample(yvector,3); %Submuestramos a 7500 Hz aproximadamente.

end