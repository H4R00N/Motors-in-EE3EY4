clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\SinusoidalData.xls';
[data,headers,raw]=xlsread(excelPath);
tS = data(:,8);
excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\TrapazoidalData.xls';
[data,headers,raw]=xlsread(excelPath);
tT = data(:,8);
[data,headers,raw]=xlsread('Q7.xls');
Iq_sin=data(:,2);
Iq_trap=data(:,4);

avgtS=mean(tS);
avgtT=mean(tT);

KtS=mean(tS./Iq_sin);
KtT=mean(tT./Iq_trap);

torqueS = mean(KtS*Iq_sin);
torqueT = mean(KtT*Iq_trap);


axis = ['ABC';'dq '];
sin = [avgtS;torqueS];
trap= [avgtT;torqueT];
avgTorque=table(axis,sin,trap)