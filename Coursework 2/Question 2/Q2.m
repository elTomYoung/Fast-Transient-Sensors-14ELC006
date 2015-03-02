%% Fast Tansient Sensors - Q2 - Coursework 2
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using 1&9 give constants as O-O 
d = 0.14*10^-3; %mm
D = 4*10^-2;    %cm
L = 10*10^-2;  %cm
p = 0.8*10^-3;  %mm
rho = 1.72*10^-8;  %Ohm-Meter
a = d/2; %radius mm

%% Part A
% Caculate the DC resistance
DCResis = rhelical(L,d,p,rho,D)

%% Part B
% Estimate the resistance at 1MHz
delta = dskin(rho,1*10^6);
RFreq = DCResis.*((a./(2*delta)).*(1+((2.*(a^2))./(p^2))))

%% Part C
% Draw a graphical representation of the resistance variation with 
% frequency up to a frequency of 1GHz.
Rcf = critf(rho,a);
% Loop to calculate resistance with frequency
RT = zeros(50);
Freq = logspace(0,7);
for ln = 1:1:50;
    if Freq(ln) >= Rcf 
        delta = dskin(rho,Freq(ln));
        RT(ln) = DCResis.*((a./(2*delta)).*(1+((2.*(a^2))./(p^2))));
    else
        RT(ln) = DCResis;
    end
end
% Plot data
loglog(Freq,RT./DCResis,'b','linewidth',2)
grid on
xlabel('Frequency')
ylabel('Ratio of ressitance at frequency to DC resistance. f(f,R) / f(0,0)')
xlim([0 1*10^9])
title('Resistance change with Frequency')

%% Part D
% Written
