function DispCaract(caract)
% Despliega en pantalla  el resultado de las caracteristicas obtenidas 
clc;
mediaF = caract(1);
disp(['Media del espectro total:',sprintf('\t\t\t'),' mediaF =  ',num2str(mediaF)])
medianF= caract(2);
disp(['Mediana del espectro total:',sprintf('\t\t\t'),' medianF = ',num2str(mediaF)])
sd= caract(3);
disp(['Desviaciòn estandar :',sprintf('\t\t\t\t'),' sd =',num2str(sd)])
Q25= caract(4);
disp(['Primer cuantil:',sprintf('\t\t\t\t\t\t'),' Q25 =',num2str(Q25)])
Q75= caract(5);
disp(['Cuarto cuantil:',sprintf('\t\t\t\t\t\t'),' Q75 = ',num2str(Q25)])
IQR= caract(6);
disp(['Rango inter cuantil:',sprintf('\t\t\t\t'),' IRQ = ',num2str(IQR)])
skew = caract(7);
disp(['Asimetrìa del espectro:',sprintf('\t\t\t\t'),' skew = ',num2str(skew)])
kurt= caract(8);
disp(['Curtosis del espectro:',sprintf('\t\t\t\t'),' kurt= ',num2str(kurt)])
spent= caract(9);
disp(['Entropìa espectral:',sprintf('\t\t\t\t\t'),' spent =', num2str(spent)])
sfm= caract(10);
disp(['Achatamiento del espectro:',sprintf('\t\t\t'),' sfm =',num2str(sfm)] )
modfrec= caract(11);
disp(['Moda del espectro:',sprintf('\t\t\t\t\t'),' modfrec = ',num2str(modfrec)])
meanfun= caract(12);
disp(['Frecuencia fundamental media:',sprintf('\t\t'),' meanfun = ',num2str(meanfun)])
minfun= caract(13);
disp(['Mìnima frecuencia fundamental:',sprintf('\t\t'),' minfun = ',num2str(minfun)])
maxfun= caract(14);
disp(['Màxima frecuencia fundamental:',sprintf('\t\t'),' maxfun = ',num2str(maxfun)])








