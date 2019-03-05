
% En este ejemplo hace falta el preprocesamiento de la señal
filename = 'bird.wav';
[y, Fs] = audioread(filename);
sound(y,Fs);
%% Análisis de los espectros
[~,~,f,dP] = centerfreq(Fs,y);
[PS,NN] = PowSpecs(y);
figure(1)
plot(f,dP);
title('Espectro de la señal total')
figure(2)
plot(Fs/2*linspace(0,1,NN-1),PS)
title('Espectro de los "tonos"')
%% Extracci�n de caracter�sticas
caract = caract_voz(y,Fs);
%% Despliegue de informaci�n de las caracter�sticas
DispCaract(caract);