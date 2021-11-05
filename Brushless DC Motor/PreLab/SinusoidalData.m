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

degrees=[['Rotor Position in degrees'];num2cell(degrees)];
IA=[['Current A'];num2cell(IA)];
IB=[['Current B'];num2cell(IB)];
IC=[['Current C'];num2cell(IC)];
fluxA=[['Flux Linkage A'];num2cell(fluxA)];
fluxB=[['Flux Linkage B'];num2cell(fluxB)];
fluxC=[['Flux Linkage C'];num2cell(fluxC)];
torque=[['No-Load Torque'];num2cell(torque)];

Sinusoidal=[degrees,IA,IB,IC,fluxA,fluxB,fluxC,torque];
xlswrite('SinusoidalData',Sinusoidal)