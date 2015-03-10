%% Fast Tansient Sensors - Q3 - Coursework 2
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using 1&9 give constants as O-O 
R = 51; %Ohms
AxL = 30*10^-3;  %mm
Evan_rho = 1.38*10^-8;  %Ohm-meter

%% Quesiton
% Design a 51 Ohm pass-through resistor
Max_Radius = dskin(Evan_rho,1*10^9)
length_max_radius = (pi.*(Max_Radius^2).*R)./Evan_rho % Over 30mm