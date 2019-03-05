     
function [VectorFinal] = clasificacionNumeros()
r1 = audiorecorder(22050, 16, 1.5);
      disp('Start speaking.')
      recordblocking(r1, 1.5);
      disp('End of Recording.');
      y1  = getaudiodata(r1);
      Fs1 = get(r1,'SampleRate');
      filename = sprintf('LordFaraon.wav');
      audiowrite(filename, y1, Fs1);
      fprintf('Saving recording: %s\n ', filename); 
k=1;
j=1;
cer='LordFaraon.wav';
Fs1=22050;
Fs=7500;
  
%Preprocesamiento
sx=audioread(cer);
[results]= preproc(Fs1,sx); 

temp=results;
[vrms,zcr]=caractiempo(temp);
mc1=vrms;
mc2=zcr;
salida=caract_voz(temp,Fs);
mc3=salida(1);
mc4=salida(2);
mc5=salida(3);
mc6=salida(4);
mc7=salida(5);
mc8=salida(6);
mc9=salida(7);
mc10=salida(8);
mc11=salida(9);
mc12=salida(10);
mc13=salida(11);
mc14= salida(12);
mc15=salida(13);
mc16=salida(14);

filename = 'FeasuresClasification.xlsx';
A = {'Descripcion','Nombre_Archivo','ValorRMS','TasaZRC','Frec_Prom','Frec_mediana','Desv_Estandar','Primer_cuantil','Tercer_Cuartil','Rango_intercuantil','Asimetria ','Curtosis','Entropia_espectral','Achatamiento_espectro','Moda','Frec_Media','Frec_Minima','Frec_maxima'};
sheet = 1;
xlRange = 'A1';
xlswrite(filename, A, sheet, xlRange);

 xlswrite(filename, mc1, 1, 'C2')
 xlswrite(filename, mc2, 1, 'D2')
 xlswrite(filename, mc3, 1, 'E2')
 xlswrite(filename, mc4, 1, 'F2')
 xlswrite(filename, mc5, 1, 'G2')
 xlswrite(filename, mc6, 1, 'H2')
 xlswrite(filename, mc7, 1, 'I2')
 xlswrite(filename, mc8, 1, 'J2')
 xlswrite(filename, mc9, 1, 'K2')
 xlswrite(filename, mc10, 1, 'L2')
 xlswrite(filename, mc11, 1, 'M2')
 xlswrite(filename, mc12, 1, 'N2')
 xlswrite(filename, mc13, 1, '02')
 xlswrite(filename, mc14, 1, 'P2')
 xlswrite(filename, mc15, 1, 'Q2')
 xlswrite(filename, mc16, 1, 'R2')
 
 VectorFinal =[mc1,mc2,mc3,mc4,mc5,mc6,mc7,mc8,mc9,mc10,mc11,mc12,mc13,mc14,mc15,mc16];
end