function [n]=asignacion()
addpath('C:\MATLAB2018\MATLAB\mcode\BioMedicine\prueba\IdentVoz-1\ale');
addpath('C:\MATLAB2018\MATLAB\mcode\BioMedicine\prueba\IdentVoz-1\sebas');
clc; close all;
n=cell(20,6);
k=1;
j=1;
cer='alecerox.wav';
uno='aleuunox.wav';
dos='aledossx.wav';
tre='aletresx.wav';
cua='alecuatx.wav';
cin='alecincx.wav';
sei='aleseisx.wav';
sie='alesietx.wav';
och='aleochox.wav';
nue='alenuevx.wav';
while(k<=10)
    switch k
        case 1
            base=cer;
            fil=1;
        case 2
            base=uno;
            fil=2;
        case 3
            base=dos;
            fil=3;
        case 4
            base=tre;
            fil=4;
        case 5
            base=cua;
            fil=5;
        case 6
            base=cin;
            fil=6;
        case 7
            base=sei;
            fil=7;
        case 8
            base=sie;
            fil=8;
        case 9
            base=och;
            fil=9;
        case 10
            base=nue;
            fil=10;
        otherwise
            base=cer;
    end
    for i=48:54
        base(8)=char(i);
        name=base;
        n{fil,j}=name;
        j=j+1;
    end
    j=1;
    k=k+1;
end
k=1;
cer='sebcerox.wav';
uno='sebuunox.wav';
dos='sebudosx.wav';
tre='sebtresx.wav';
cua='sebctrox.wav';
cin='sebcncox.wav';
sei='sebseisx.wav';
sie='sebsetex.wav';
och='sebochox.wav';
nue='sebnovex.wav';
while(k<=10)
    switch k
        case 1
            base=cer;
            fil=11;
        case 2
            base=uno;
            fil=12;
        case 3
            base=dos;
            fil=13;
        case 4
            base=tre;
            fil=14;
        case 5
            base=cua;
            fil=15;
        case 6
            base=cin;
            fil=16;
        case 7
            base=sei;
            fil=17;
        case 8
            base=sie;
            fil=18;
        case 9
            base=och;
            fil=19;
        case 10
            base=nue;
            fil=20;
        otherwise
            base=cer;
    end
    for i=48:54
        base(8)=char(i);
        name=base;
        n{fil,j}=name;
        j=j+1;
    end
    j=1;
    k=k+1;
end
end
