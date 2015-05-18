%% Fast Tansient Sensors - Q4 - Coursework 3
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
%Global constants
u0 = 4*pi*10^-7;  % H/m
e0 = 8.85*10^-12; % F/m
copper_rho = 1.7*10^-8;
%Bank Constants
Cb = 100*10^-6;
Trans_width = 40*10^-2;
Vo = 30*10^3;
Lb = 50*10^-9;
Rb = 0;
Q = 0;
I = 1;
%Probe constants
Pr_tunnel = 15*10^-3;
Pr_diameter = 3*10^-3;
Pr_MaxV = 200;
Pr_area  = pi.*(Pr_diameter./2)^2;

%% Current Discharge
%Bank Current Discharge
dI = (Vo-(Q./Cb)-(Rb.*I))./Lb
%Peak Mag Flux Change
L = 40*10^-2;
r = 0;
a = Pr_tunnel./2;
z = 0;
Bz = baxial(a,r,z,L,I);
dB = Bz.*dI

%% Probe Design
%Coil Length
z = 0:1*10^-4:20*10^-2;
BzInc = zeros(0,length(z));
for n = 1:length(z)
    BzInc(n) = baxial(a,r,z(n),L,I);
end
figure
plot(z.*10^2,BzInc.*10^6,'Linewidth',2)
xlabel('Distance along transmission line (cm)')
ylabel('Flux (\muT)')
title('Flux Along Transmission Line Width')
grid on
Pr_length = 30*10^-2;
%Number of turns
Nt = Pr_MaxV./(Pr_area.*dB)
%Inductance
indPr = indhelical(Nt,Pr_diameter./2,Pr_length)
%Resistance
freq = 1/(2*pi*sqrt(Lb*Cb));
wire_diameter = round(dskin(copper_rho,freq).*10^4).*10^-4;
p = Pr_length./Nt;
rPr = rhelical(Pr_length,wire_diameter,p,copper_rho,Pr_diameter/2)
%Capacitance
cPr = ccoil(Pr_diameter/2,p,wire_diameter/2)./Nt
%Demonstration
Rt = 50;
Rsys = 50+rPr;
Xl = (2.*pi.*freq).*indPr;
if Xl < Rsys 
    disp('Probe is differentiating')
else
    disp('Probe is self-integrating')
end
DCatten = Rt./(Rt+rPr);
S = 0;
Vout = DCatten.*(S.*dB);
%% Calibration


%% 
















