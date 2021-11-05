clear
close all
clc

excelPath = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab3\PreLab\NoLoadData.xls';
[data,headers,raw]=xlsread(excelPath);

degrees=data(:,1);
fluxA=data(:,2);
fluxB=data(:,3);
fluxC=data(:,4);
theta=((2*pi/180)*degrees);%0->2pi increasing by 0.02pi

[f_a, f_b]=Clarke(fluxA, fluxB, fluxC);
[fd, fq]=Park(f_a,f_b,theta,0);

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

%plots all fluxes vs motor rotation
figure(2)
plot(degrees,fd,'r')
hold on
plot(degrees,fq,'b')
diff = abs(mean(fq-fd));
axis([0 degrees(end) min([min(fd) min(fq)])-diff/2 max([max(fd) max(fq)])+diff/2])
xlabel('Rotor Position (Degrees)')
ylabel('Voltage (V)')
title('No-Load stationary two-axis Phase Voltage in a Rotating Reference')
legend('d','q')
hold off

%% Clark Transformation
function [alpha,beta] = Clarke(u,v,w)
    alpha=(2/3)*(u*1+v*(-1/2)+w*(-1/2));
    beta=(2/3)*(u*0+v*(sqrt(3)/2)+w*(-sqrt(3)/2));
end
%% Park Transformation
function [d,q] = Park(alpha,beta,theta,pp)
    for i=1:length(theta)
        d(i)=alpha(i)*(cosd(theta(i)*pp)+beta(i)*sind(theta(i)*pp));
        q(i)=alpha(i)*(-sind(theta(i)*pp)+beta(i)*cosd(theta(i)*pp));
    end
end