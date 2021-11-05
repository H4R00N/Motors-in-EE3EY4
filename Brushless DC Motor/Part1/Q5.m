clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\NoLoadData.xls';
[data,headers,raw]=xlsread(excelPath);

degrees=data(:,1);
voltageA = diff(data(:,2))*25*2*pi/3.6;
voltageB = diff(data(:,3))*25*2*pi/3.6;
voltageC = diff(data(:,4))*25*2*pi/3.6;
degrees(end)=[];
Va=[]; Vb=[]; Vd=[]; Vq=[];
clarkeT = (2/3)*[1,-1/2,-1/2;0,sqrt(3)/2,-sqrt(3)/2];
theta=((2*pi/180)*degrees);%0->2pi increasing by 0.02pi

for i=1:size(voltageA)
    V=clarkeT*[voltageA(i);voltageB(i);voltageC(i)];
    Va(end+1,:) = V(1,:);
    Vb(end+1,:) = V(2,:);
end

for i = 1:size(Va);
    parkT = [cos(theta(i)),sin(theta(i));-sin(theta(i)),cos(theta(i))];
    V=parkT*[Va(i);Vb(i)];
    Vd(end+1,:) = V(1,:);
    Vq(end+1,:) = V(2,:);
end

%plots all voltages vs motor rotation
figure(1)
plot(degrees,Va,'r')
hold on
plot(degrees,Vb,'b')
axis([0 degrees(end) min([min(Va) min(Vb)]) max([max(Va) max(Vb)])])
xlabel('Rotor Position (Degrees)')
ylabel('Voltage (V)')
title('No-Load stationary two-axis Phase Voltage')
legend('alpha','beta')
hold off

%plots all voltages vs motor rotation
figure(2)
plot(degrees,Vd,'r')
hold on
plot(degrees,Vq,'b')
diff = abs(mean(Vq-Vd));
axis([0 degrees(end) min([min(Vd) min(Vq)])-diff/2 max([max(Vd) max(Vq)])+diff/2])
xlabel('Rotor Position (Degrees)')
ylabel('Voltage (V)')
title('No-Load two-axis Phase Voltage in a Rotating Reference')
legend('d','q')
hold off

%store in excel to use for other questions
Va=[['Voltage alpha'];num2cell(Va)];
Vb=[['Voltage beta'];num2cell(Vb)];
Vd=[['Voltage d'];num2cell(Vd)];
Vq=[['Voltage q'];num2cell(Vq)];
out=[Va,Vb,Vd,Vq];
xlswrite('Q5',out)