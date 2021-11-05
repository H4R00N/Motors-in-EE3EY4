clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\NoLoadData.xls';
[data,headers,raw]=xlsread(excelPath);

degrees=data(:,1);
fluxA=data(:,2);
fluxB=data(:,3);
fluxC=data(:,4);

%plots all fluxes vs motor rotation
figure(1)
plot(degrees,fluxA,'r')
hold on
plot(degrees,fluxB,'b')
hold on
plot(degrees,fluxC,'g')
axis([0 degrees(end) min([min(fluxA) min(fluxB) min(fluxC)]) max([max(fluxA) max(fluxB) max(fluxC)])])
xlabel('Rotor Position (Degrees)')
ylabel('Flux (Vm)')
title('No-Load Flux Linkage')
legend('A','B','C')
hold off