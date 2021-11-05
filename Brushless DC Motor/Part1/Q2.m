clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\NoLoadData.xls';
[data,headers,raw]=xlsread(excelPath);

degrees=data(:,1);
fluxA=data(:,2);
fluxB=data(:,3);
fluxC=data(:,4);

%plots all induced voltage vs motor rotation
figure(1)
voltageA = diff(fluxA)*25*2*pi/3.6;
voltageB = diff(fluxB)*25*2*pi/3.6;
voltageC = diff(fluxC)*25*2*pi/3.6;
degrees(end)=[];
plot(degrees,voltageA, 'r')
hold on
plot(degrees,voltageB, 'b')
hold on
plot(degrees,voltageC, 'g')
xlabel('Rotor Position (Degrees)')
ylabel('Voltage (V)')
axis([0 degrees(end) min([min(voltageA) min(voltageB) min(voltageC)]) max([max(voltageA) max(voltageB) max(voltageC)])])
title('No-Load Phase Voltage')
legend('A','B','C')
hold off