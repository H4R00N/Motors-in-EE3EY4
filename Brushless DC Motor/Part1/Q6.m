clear
close all
clc

[data,headers,raw]=xlsread('Q4.xls');
fd=data(:,1);
fq=data(:,2);
[data,headers,raw]=xlsread('Q5.xls');
Vd=data(:,3);
Vq=data(:,4);

%1/dt=1/(dλ/ε)=ω
wd_RPM=1/(sum(diff(fd)./Vd))
wq_RPM=1/(sum(diff(fq)./Vq))