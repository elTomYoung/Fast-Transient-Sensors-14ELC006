%% Fast Tansient Sensors - Q6 - Coursework 2
% B126949 - Tom Young
%% Pre - Cursor
clc
clear all

%% Variables
u0 = 4*pi*10^-7; % Free space permeability
e0 = 8.85*10^-12; % Free space permittivity
Z0 = 15; % 15Ohms
L = 1.25; % 1.25m - axial length
er = 2.25; % relative permittivity
V0 = 60*10^3; % 60kV
t = 37.6*10^-9; % 37.6ns
T = [1,2,3];

%% Part A
Z1 = Z0;
VPFL1 = (V0*Z1)/(Z0+Z1);
rhoL = (Z1-Z0)/(Z1+Z0);
VL1 = VPFL1;
VL2 = VL1*rhoL;
VL3 = VL2*rhoL;
V1 = [VL1,VL2,VL3];

% Plot
figure
bar(T,V1./10^3,1);
title('Load Voltage Waveform for Z_{L} = Z_{0}');
ylabel('V(kV)');
xlabel('T');
grid on


%% Part B
Z2 = 5*Z0;
VPFL2 = (V0*Z2)/(Z0+Z2);
rhoL = (Z2-Z0)/(Z2+Z0);
VL1 = VPFL2;
VL2 = VL1*rhoL;
VL3 = VL2*rhoL;
V2 = [VL1,VL2,VL3];

% Plot
figure
bar(T,V2./10^3,1);
title('Load Voltage Waveform for Z_{L} = 5Z_{0}');
ylabel('V(kV)');
xlabel('T');
grid on

%% Part C
Z3 = Z0/5;
VPFL3 = (V0*Z3)/(Z0+Z3);
rhoL = (Z3-Z0)/(Z3+Z0);
VL1 = VPFL3;
VL2 = VL1*rhoL;
VL3 = VL2*rhoL;
V3 = [VL1,VL2,VL3];

% Plot
figure
bar(T,V3./10^3,1);
title('Load Voltage Waveform for Z_{L} = Z_{0}/5 ');
ylabel('V(kV)');
xlabel('T');
grid on