clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\SinusoidalData.xls';
[data,headers,raw]=xlsread(excelPath);
degrees=data(:,1);
IAsin=data(:,2);
IBsin=data(:,3);
ICsin=data(:,4);

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\TrapazoidalData.xls';
[data,headers,raw]=xlsread(excelPath);
degrees=data(:,1);
IAtrap=data(:,2);
IBtrap=data(:,3);
ICtrap=data(:,4);

Isin_a=[]; Isin_b=[]; Isin_d=[]; Isin_q=[]; Itrap_a=[]; Itrap_b=[]; Itrap_d=[]; Itrap_q=[];
clarkeT = (2/3)*[1,-1/2,-1/2;0,sqrt(3)/2,-sqrt(3)/2];
theta=((2*pi/180)*degrees);%0->2pi increasing by 0.02pi

for i=1:size(IAsin)
    Isin=clarkeT*[IAsin(i);IBsin(i);ICsin(i)];
    Itrap=clarkeT*[IAtrap(i);IBtrap(i);ICtrap(i)];
    Isin_a(end+1,:) = Isin(1,:);
    Isin_b(end+1,:) = Isin(2,:);
    Itrap_a(end+1,:) = Itrap(1,:);
    Itrap_b(end+1,:) = Itrap(2,:);
end

for i = 1:size(Isin_a);
    parkT = [cos(theta(i)),sin(theta(i));-sin(theta(i)),cos(theta(i))];
    Isin=parkT*[Isin_a(i);Isin_b(i)];
    Itrap=parkT*[Itrap_a(i);Itrap_b(i)];
    Isin_d(end+1,:) = Isin(1,:);
    Isin_q(end+1,:) = Isin(2,:);
    Itrap_d(end+1,:) = Itrap(1,:);
    Itrap_q(end+1,:) = Itrap(2,:);
end


%plots the 3 currents vs motor rotation
figure(1)
plot(degrees,Isin_d,'r')
hold on
plot(degrees,Isin_q,'b')
axis([0 degrees(end) min([min(Isin_d) min(Isin_q)]) max([max(Isin_d) max(Isin_q)])])
xlabel('Phase (Degrees)')
ylabel('Current (A)')
title('Sinusoidal two-axis Current in a Rotating Reference')
legend('d','q')
hold off

%plots the 3 currents vs motor rotation
figure(2)
plot(degrees,Itrap_d,'r')
hold on
plot(degrees,Itrap_q,'b')
axis([0 degrees(end) min([min(Itrap_d) min(Itrap_q)]) max([max(Itrap_d) max(Itrap_q)])])
xlabel('Phase (Degrees)')
ylabel('Current (A)')
title('Trapazoidal two-axis Current in a Rotating Reference')
legend('d','q')
hold off

%store in excel to use for other questions
Isin_d=[['Sinusoidal Current d'];num2cell(Isin_d)];
Isin_q=[['Sinusoidal Current q'];num2cell(Isin_q)];
Itrap_d=[['Trapazoidal Current d'];num2cell(Itrap_d)];
Itrap_q=[['Trapazoidal Current q'];num2cell(Itrap_q)];
out=[Isin_d,Isin_q,Itrap_d,Itrap_q];
xlswrite('Q7',out)