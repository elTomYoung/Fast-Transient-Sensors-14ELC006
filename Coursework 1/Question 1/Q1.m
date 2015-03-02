%% Fast Tansient Sensors - Q1
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using B126949 give constants as O-O 
u_0 = 4*pi*10^-7;
p = 1*10^-3; % pitch in meters.
N = 60;
dc = 10*10^-3; % Diameter of coil in meters.
a = 30*10^-3; % distance to coil from origin.
I = 100; % amps

% p = 1.2*10^-3;
% N = 75;
% dc = 9*10^-3;
% a = 27*10^-3;
% I = 220;

%% Part A
% Calculate the magnetic flux density at the origin produced by one coil.
coil_length = N*p;
B_axis_singlecoil = bhelical(dc/2,N,coil_length,I,a+(coil_length/2))

%% Part B
% Calculate the resultant magnetic field from all 3 coils at the origin.
% All coils produce the same field strength at the origin
Br_mag = sqrt(3*((B_axis_singlecoil)^2))
% Angle between the resultant vector and each axis
Br_angle = acosd(-B_axis_singlecoil/Br_mag)

%% Part C
% Calculate magnetic field when col enrgised to produce field away from
% origin.
% Magnitude of resultat stays the same;
Br_mag = sqrt(3*(B_axis_singlecoil)^2)
% Change to angle on one coil
Br_angle_c1 = acosd(-B_axis_singlecoil/Br_mag)
Br_angle_c2 = acosd(-B_axis_singlecoil/Br_mag)
Br_angle_c3 = acosd(B_axis_singlecoil/Br_mag)

%% Part D
% Draw magnetic field along axis of coil.
hold on
z_point = (0:coil_length/1000:coil_length);
Br = bhelical(dc/2,N,coil_length,I,z_point);
plot(z_point,Br*1000,'r')
title('Magnetic Flux Density Along Coil Axis')
xlabel('x (m)')
ylabel('Magnetic Flux ensity (mT)')
hold off
