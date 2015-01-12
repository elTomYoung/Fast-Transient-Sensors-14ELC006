%% Fast Tansient Sensors - Q3
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using B126949 give constants as O-O 
u_0 = 4*pi*10^-7;
p = 2*10^-3;
L = 200*10^-3;
d = 20*10^-3;
Z1 = 20*10^-3;
Z2 = 120*10^-3;
Z3 = Z1+Z2+L;

%% Part A
% Calcualte the self inductance of each coil
% All coils share same properties
Nc = L/p;
Lc = indhelical(Nc,d/2,L)

%% Part B
% Calculate the mutual inductance between all pairs of coils.

%M12
Nc3 = Z1/p;
Nc123 = (L+L+Z1)/p;
Nc23 = (L+Z1)/p;
Nc13 = (L+Z1)/p;
L123 = indhelical(Nc123,d/2,(L+L+Z1));
L13 = indhelical(Nc13,d/2,L+Z1);
L23 = indhelical(Nc23,d/2,L+Z1);
L3 = indhelical(Nc3,d/2,Z1);
M12 = 0.5*(L123+L3-L13-L23)

%M13
Nc3 = (Z1+Z2+L)/p;
Nc123 = (Z1+Z2+L+L+L)/p;
Nc23 = (Z1+Z2+L+L)/p;
Nc13 = (Z1+Z2+L+L)/p;
L123 = indhelical(Nc123,d/2,(Z1+Z2+L+L+L));
L13 = indhelical(Nc13,d/2,(Z1+Z2+L+L));
L23 = indhelical(Nc23,d/2,(Z1+Z2+L+L));
L3 = indhelical(Nc3,d/2,(Z1+Z2+L));
M13 = 0.5*(L123+L3-L13-L23)

%M23
Nc3 = Z2/p;
Nc123 = (L+L+Z2)/p;
Nc23 = (L+Z2)/p;
Nc13 = (L+Z2)/p;
L123 = indhelical(Nc123,d/2,(L+L+Z2));
L13 = indhelical(Nc13,d/2,L+Z2);
L23 = indhelical(Nc23,d/2,L+Z2);
L3 = indhelical(Nc3,d/2,Z2);
M23 = 0.5*(L123+L3-L13-L23)

%% Part C
% Total inductance of system
Lsys = (3*Lc)+2*(M12+M13+M23)
