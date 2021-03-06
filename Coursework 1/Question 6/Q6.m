%% Fast Tansient Sensors - Q6
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using B126949 give constants as O-O
u_0 = 4*pi*10^-7;
L = 8;
d = 0.1*10^-3;
t = 0.02*10^-3;
Lm = 100*10^-3;
dm = 4*10^-3;
l = 10*10^-3;
e_r = 2.3;
rm = dm/2;
r = d/2;

%% Part A
% DC resistance of coil.
resis_copper = 1.72*10^-8; %ohmic meters
cs_area = pi*((d/2)^2);
R_coil = (resis_copper*L)/cs_area;

%% Part B
% Coil Inductance
p_num = ((2*pi*((dm/2)+t))^2)*(Lm^2);
p_denum = ((L-(2*l))^2) - (Lm^2);
p = sqrt(p_num/p_denum);
N = Lm/p;
L_coil = indhelical(N,(dm/2)+t,Lm);

%% Part C
% Capacitence
per_coil_pair = ccoil((rm+t),p,d/2,2.3,t);
C_coil = per_coil_pair*N;

%% Part D
% Calculate supplement capacitance and indutance from connecting into a
% circuit.
L_added = indpoly('Rectangle',Lm,l,d/2)
% L_added = indtrans(r,(Lm-(2*(t+r))));
C_added = ctrans(Lm-(2*(r+t)),d/2).*l

%% Part E
% Resonant frequency of an arrangement in d
L_total = L_coil + L_added;
C_total = C_coil + C_added;
f0 = 1/(2*pi*sqrt(L_total*C_total))

%% Part F
% Variation in coil impedence with f->1GHz. Assuming constant resistance.
FreqRange = 1*10^5:1000:1*10^9;
omega = 2.*pi.*FreqRange;
num = 1+(((1i.*omega).*L_coil)./R_coil);
denum = 1+((1i.*omega).^2).*L_coil.*C_coil+(1i.*omega).*R_coil.*C_coil;
%Resp = freqrespreal(omega,L_coil,R_coil,C_coil);
zl = R_coil.*(num./denum);
% figure('Name','Magnitude')
loglog(FreqRange,zl) %Resistor at start, inductor at peak, cap at end
title('Coil Impedance with Frequency')
xlabel('Frequency (Hz)')
ylabel('Impedance (Ohms)')
grid on
grid minor
