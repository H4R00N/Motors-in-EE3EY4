clear
close all
clc

[data,headers,raw]=xlsread('Q3.xls');
degrees=[0:3.6:180]';
f_a=data(:,1);
f_b=data(:,2);
fd=[]; fq=[];
theta=((2*pi/180)*degrees);%0->2pi increasing by 0.02pi

for i = 1:size(f_a);
    parkT = [cos(theta(i)),sin(theta(i));-sin(theta(i)),cos(theta(i))];
    F=parkT*[f_a(i);f_b(i)];
    fd(end+1,:) = F(1,:);
    fq(end+1,:) = F(2,:);
end

%plots all fluxes vs motor rotation
figure(1)
plot(degrees,fd,'r')
hold on
plot(degrees,fq,'b')
diff = abs(mean(fq-fd));
axis([0 degrees(end) min([min(fd) min(fq)])-diff/2 max([max(fd) max(fq)])+diff/2])
xlabel('Rotor Position (Degrees)')
ylabel('Flux (Vm)')
title('No-Load two-axis Flux Linkage in a Rotating Reference')
legend('d','q')
hold off

%store in excel to use for other questions
fd=[['flux d'];num2cell(fd)];
fq=[['flux q'];num2cell(fq)];
out=[fd,fq];
xlswrite('Q4',out)