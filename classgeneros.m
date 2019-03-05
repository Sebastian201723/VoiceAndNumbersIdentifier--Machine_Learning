%% COMENZAMOS HACIENOD EL ENTRENAMIENTO DE LOS CLASIFICADORES CON LOS 
%DATASETS DE 70 REGISTROS POR CADA PERSONA. PRIMERO SE HACE POR GENERO:

%% ENTRENAMIENTO POR GENERO:

%[W,IminE,PC,mejorclasificador]=loop();
L=length(IminE);

for i=1:L
    wmap=W(1,i);
    wm=wmap{1,1};
    
end

%% CLASIFICACION POR GENEROS
VectorClasificacion = clasificacionNumeros();

DatasetTotal2 = prdataset(VectorClasificacion);

LABEL = labeld(DatasetTotal2,Ws*PC*w3)