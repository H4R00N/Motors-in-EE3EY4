clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\NoLoadData.xls';
[data,headers,raw]=xlsread(excelPath);

degrees=data(:,1);
fluxA=data(:,2);
fluxB=data(:,3);
fluxC=data(:,4);
f_a=[]; f_b=[];
clarkeT = (2/3)*[1,-1/2,-1/2;0,sqrt(3)/2,-sqrt(3)/2];

for i=1:size(fluxA)
    F=clarkeT*[fluxA(i);fluxB(i);fluxC(i)];
    f_a(end+1,:) = F(1,:);
    f_b(end+1,:) = F(2,:);
end

%plots all fluxes vs motor rotation
figure(1)
plot(degrees,f_a,'r')
hold on
plot(degrees,f_b,'b')
axis([0 degrees(end) min([min(f_a) min(f_b)]) max([max(f_a) max(f_b)])])
xlabel('Rotor Position (Degrees)')
ylabel('Flux (Vm)')
title('No-Load stationary two-axis Flux Linkage')
legend('alpha','beta')
hold off

%store in excel to use for other questions
f_a=[['Flux alpha'];num2cell(f_a)];
f_b=[['Flux beta'];num2cell(f_b)];
out=[f_a,f_b];
xlswrite('Q3',out)