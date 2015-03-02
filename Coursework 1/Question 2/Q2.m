%% Fast Tansient Sensors - Q2
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using B126949 give constants as O-O 
u_0 = 4*pi*10^-7;
x = 0.1;
N1 = 5;
N2 = 4;
R1 = 0.2;
R2 = 0.004;
I1 = 100;
I2 = 200;

%% Part A
% Calculate magnetic field midway between coils

% i) Current is same direction
B1 = bloop(R1,I1,0,x/2)
B2 = bloop(R2,I2,0,x/2) 
Br_same = B1 + B2
% ii) Current in opposite direction
Br_opp = B1 - B2

%% Part B 
% Calculate the magnetic field at point x along the axis of coil 1
Br = bloop(R1,I1,0,x)
% Mutual indctance estimation
area_c2 = pi*(R2^2);
M21_est = ((N2^2)/I1)*(Br*area_c2)

%% Part C
% Calculate magnetic flux Coil1 -> Coil2
B_c1 = bloop(R1,I1,R2,x)

%% Part D
% Calculate magnetic flux Coil2 -> Coil1
B_c2 = bloop(R2,I2,R1,x)

%% Part E
% Mutual Inductnce between both coils
k = (2*sqrt(R1*R2))/sqrt((R1+R2)^2+x^2);
[K E] = ellipke(k);
M21_act_pre = (2*u_0*sqrt(R1*R2))/k;
M21_act = M21_act_pre*((1-((k^2)/2))*K-E)
