%% Fast Tansient Sensors - Q4
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
V = 1;
t = 3*10^-3;
D = 40*10^-3;
d = 20*10^-3;
e_r = 2.4;

%% Part A
% Maxwell

%% Part B
% Calculate E=V/d
E = V/d

%% Part C
% Maxwell

%% Part D
% Estimate capacitance of capacitor using provided formula.
s_area = pi*(D/2)^2;
C = e_r*(s_area/d)