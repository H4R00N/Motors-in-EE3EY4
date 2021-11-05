clc;
clear;
close all;

%this is just to copy the FEM model since rotating the file will change it permentaly
%this is also why this code will delete the copy it makes later
%so change path to where the FEM file you downloaded is
path = 'C:\Users\Huzai\Haroon\OneDrive - McMaster University\McMaster\Third Year\Second Semester\EE3EY4\Lab2\3EY4_Lab2.fem';
copyfile(path, '3EY4_15deg.fem');

addpath('c:\\femm42\\mfiles');%gets the commands that will allow matlab to interact with FEMM

openfemm(1)%opens FEMM minimized
opendocument('3EY4_15deg.fem');%opens file that was copied

n=50;%number of steps for half a rotation
degrees=[0:3.6:n*3.6]';%gets n degrees increasing from 0 by 3.6(the degree for 1 step)
%makes variables for fluxes and torques
fluxA=zeros(n+1,1);
fluxB=zeros(n+1,1);
fluxC=zeros(n+1,1);
torque=zeros(n+1,1);
%make currents sinusoidal and make them out of phase from each other by 120 degrees
%T=180degrees, A = 1, theta = 0, 120, 240
IA = sin((2*pi/180)*degrees);
IB = sin((2*pi/180)*(degrees+120));
IC = sin((2*pi/180)*(degrees+240));

for k=0:n%runs for each step
    fprintf('iteration %i of %i\n',k,n);
    
    %set the sinusoidal current at current step
    mi_setcurrent('A',IA(k+1));
    mi_setcurrent('B',IB(k+1));
    mi_setcurrent('C',IC(k+1));
    
    %analyse and load soln
    mi_analyze;
    mi_loadsolution;
    
    %get circuit properties for each property and gets the torque
    g1=mo_getcircuitproperties('A');
    g2=mo_getcircuitproperties('B');
    g3=mo_getcircuitproperties('C');
    mo_groupselectblock(1)
    torque(k+1)=mo_blockintegral(22);
    
    %get all the fluxes from each circuit property
    fluxA(k+1)=g1(1,3);
    fluxB(k+1)=g2(1,3);
    fluxC(k+1)=g3(1,3);
    
    %closes the soln and selects the motor to turn by 1 step i.e. 3.6 degrees
    mo_close;
    mi_seteditmode('group');
    mi_selectgroup(1);
    mi_moverotate(0,0,3.6);
    mi_clearselected();
end

%closes FEMM and deletes everything it copied and made
closefemm;
delete('3EY4_15deg.ans')
delete('3EY4_15deg.fem');

%plots the 3 currents vs motor rotation
figure(1)
plot(degrees,IA,'r')
hold on
plot(degrees,IB,'b')
hold on
plot(degrees,IC,'g')
axis([0 degrees(end) min([min(IA) min(IB) min(IC)]) max([max(IA) max(IB) max(IC)])])
xlabel('Phase (Degrees)')
ylabel('Current (A)')
title('Sinusoidal Current')
legend('A','B','C')
hold off

%plots all fluxes vs motor rotation
figure(2)
plot(degrees,fluxA,'r')
hold on
plot(degrees,fluxB,'b')
hold on
plot(degrees,fluxC,'g')
axis([0 degrees(end) min([min(fluxA) min(fluxB) min(fluxC)]) max([max(fluxA) max(fluxB) max(fluxC)])])
xlabel('Phase (Degrees)')
ylabel('Flux (Vm)')
title('Sinusoidal Flux Linkage')
legend('A','B','C')
hold off

%plots torque vs motor rotation
figure(3)
plot(degrees,torque)
xlabel('Phase (Degrees)')
ylabel('Torque (Nm)')
axis([0 degrees(end) min(torque) max(torque)])
title('Sinusoidal Torque')

%plots all induced voltage vs motor rotation
figure(4)
voltageA = diff(fluxA)*25*2*pi/3.6;
voltageB = diff(fluxB)*25*2*pi/3.6;
voltageC = diff(fluxC)*25*2*pi/3.6;
degrees(end)=[];
plot(degrees,voltageA, 'r')
hold on
plot(degrees,voltageB, 'b')
hold on
plot(degrees,voltageC, 'g')
xlabel('Phase (Degrees)')
ylabel('Voltage (V)')
axis([0 degrees(end) min([min(voltageA) min(voltageB) min(voltageC)]) max([max(voltageA) max(voltageB) max(voltageC)])])
title('Sinusoidal Induced Voltage')
legend('A','B','C')
hold off
