clc 
clear all
addpath('C:\Program Files\MATLAB\R2018a\prtools')
%% Sistema de clasificacion de voces y numeros

%% 1 CONVERSIÓN A/D
% Se realiza muestreo inicial con Frecuencia de Muestreo: 22050 hz
% Rango de voz Humana considerado: [250-3000] hz 
% Frecuencia máxima considerada: 3khz
% Frecuencia Nyquist: 6khz
% Frecuencia Nyquist despues del downsample: 7350 hz
% Se Organizan audios en un Cell Array para su fácil manipulación.

nombres=asignacion();

Fs1=22050;
Fs=7500;

results=cell(20,7);                    

%% 2. PRE-PROCESAMIENTO
%   2.1. Se implementa ventana Hanning 
%   2.2. Se diseña filtro FIR pasabajo con frecuencia de corte 3khz.
%   2.3. Compensación por Retardo de Grupo.
%   2.4. Se elimina Ruido a 60 hz (filtro pasa banda)
%   2.5. Se implementa filtro de Pre Enfasis con coef compensación MU=0.95
%   2.6. Se implementa filtro de remoción de silencios

for i=1:20
    for j=1:7
        sx=audioread(nombres{i,j});
        results{i,j}= preproc(Fs1,sx); 
    end          
end

%% 3. EXTRACCION DE CARACTERISTICAS
%   3.1 Extracción del rms de la envolvente de la señal y cruces por cero
mc1=[]; 
mc2=[];
% CARACTERISTICAS:
% 1. Valor RMS de la envolvente de la señal.
% 2. Tasa de cruces por cero de la señal.
% 3. Frecuencia promedio
% 4. Frecuencia mediana
% 5. DesviaciÃ³n estandar
% 6. Primer cuantil
% 7. Tercer cuantil
% 8. Rango intercuantil
% 9. AsimetrÃ­a 
% 10. Curtosis
% 11. EntropÃ­a espectral
% 12. Achatamiento del espectro
% 13. Moda del espectro
% 14. Frecuencia fundamental media
% 15. Frecuencia fundamental mÃ­nima
% 16. Frecuencia fundamental mÃ¡xima
for i=1:20
    for j=1:7
        temp=results{i,j};
        [vrms,zcr]=caractiempo(temp);
        mc1(i,j)=vrms;
        mc2(i,j)=zcr;
        salida=caract_voz(temp,Fs);
        mc3(i,j)=salida(1);
        mc4(i,j)=salida(2);
        mc5(i,j)=salida(3);
        mc6(i,j)=salida(4);
        mc7(i,j)=salida(5);
        mc8(i,j)=salida(6);
        mc9(i,j)=salida(7);
        mc10(i,j)=salida(8);
        mc11(i,j)=salida(9);
        mc12(i,j)=salida(10);
        mc13(i,j)=salida(11);
        mc14(i,j)= salida(12);
        mc15(i,j)=salida(13);
        mc16(i,j)=salida(14);
    end
end

%% CREACION DEL DATASET EN EXCEL

filename = ExportToExcel(nombres,vrms,zcr,mc1,mc2,mc3,mc4,mc5,mc6,mc7,mc8,mc9,mc10,mc11,mc12,mc13,mc14,mc15,mc16);

%% CLASIFICACION PARTE 1: GENERO

addpath('C:\MATLAB2015\mcode\BioMedicine\prtools')% Path al directorio donde està instalado prtools
% Leer datos desde archivo Excel
filename = 'Feasures.xlsx';
sheet = 1;
xlRange = 'C2:R141';
Dataset = xlsread(filename, sheet, xlRange);    %Cargamos dataset desde archivo Excel

%% NORMALIZACION
Dataset = normc(Dataset);

%% ESTABLECIMIENTO DE ATRIBUTOS PARA EL CLASIFICADOR
lista_feasures = char('ValorRMS','TasaZRC','Frec_Prom','Frec_mediana','Desv_Estandar','Primer_cuantil','Tercer_Cuartil','Rango_intercuantil','Asimetria ','Curtosis','Entropia_espectral','Achatamiento_espectro','Moda','Frec_Media','Frec_Minima','Frec_maxima');
%% Clasificacion Genero (Posibilidad 1)
% **Posibilidad 2 de clasificacion: 
%   Frecuencia hombre: 85-150 hz
%   Frecuencia mujer:  180-225 hz
%   Crear clasificacion usando Frecuencia Max, Min,y Media

lista_clase(1:70) = 'F';     % F: Mujer
lista_clase(71:140) = 'M';   % M: Hombre
lista_clase = lista_clase';

%% EXPORTACION DE CONJUNTO DE DATOS
% A = prdataset (DATA, LABELS)
%   DATA : Tamaño [M,K], M datavectores de tamaño K 
%   LABELS: Tamaño [M,N], Array para M datavectores
%   featlab: size [K,F] array with labels for the K features
DatasetTotal = prdataset(Dataset, lista_clase,'featlab',lista_feasures);

%% SELECCION DE CARACTERISTICAS
%   featselm(TrainingSet,Criterium, Method, Number of Feasures)
%   Method NN : DEFAULT
% 	Ws: Feature selection mapping
%   R: Matrix with step by step results

No_feasures = 16;                                        % Atributos Seleccionados
[Ws,Rs] = featselm(DatasetTotal,'NN','ind',No_feasures); % Feasure Selection map
DatasetTotal = DatasetTotal*Ws;                          % Map According to Attibutes selected
DatasetTotal.featlab                                     % Despliegue de las caracterìsticas seleccionadas
%% SELECCION DATOS DE ENTRENAMIENTO Y DE PRUEBA
%   [A,B,IA,IB] = gendat(X,N,SEED)
%   X:DATASET
%   N:Fila de elementos de cada clase
%   A, B: DATASETS
%   IA,IB: Indices originales

randreset;                                               % Para que la semilla del generador aleatorio de datos sea siempre la misma 
[Ae,Ap,IL,IU] = gendat(DatasetTotal,0.9);%% 
figure
scatterd(DatasetTotal);                                  % Datos para dos caracterìsticas

%% ANALISIS DE COMPONENTES PPALES
PC = pcam(Ae,0.99999);
figure
scatterd(DatasetTotal*PC);   

%% ENTRENAMIENTO DE LOS CLASIFICADORES
w1 = nmc(Ae*PC); 
w2 = knnc(Ae*PC,3);
w3 = ldc(Ae*PC);        %linear
w4 = qdc(Ae*PC);        % quadratic
w5 = parzenc(Ae*PC);    % Parzen
w6 = dtc(Ae*PC);        % decision tree
w7 = svc(Ae*PC,proxm('p',6));
w8 = neurc(Ae*PC);      % Neuronal
w9 = adaboostc(Ae*PC,perlc([],1),50,[],1); %AdaBoost

% Compute and display errors
% Store classifiers in a cell
W = {w1,w2,w3,w4,w5,w6,w7,w8,w9};
name_classf = {'nmc','knnc','ld','qdc','parzenc','dtc','svc','neurc','adaboostc'};
[E,C]=testc(Ap*PC*W); % E, error, C{i} # errores de clasificaciòn en cada clase. Ver tambien confmat  
disp('Error de los clasificadores')
disp(E)
disp('Error minimo')
minE = min(E);
disp(minE)
IminE = find(E==minE);
disp('Mejores Clasificadores')  % Nombres de los clasificadores con mìnimo error de clasificaciòn
disp(name_classf(IminE))
mejorclasificador=name_classf(IminE);
%% Matriz de confusion para clasificador w1
confmat(Ap*PC*w1);
%% CLASIFICACION POR GENERO
VectorClasificacion = clasificacionGenero();

DatasetTotal2 = prdataset(VectorClasificacion);

LABEL = labeld(DatasetTotal2,Ws*PC*w3)
