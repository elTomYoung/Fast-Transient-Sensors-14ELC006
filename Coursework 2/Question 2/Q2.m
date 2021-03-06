%% Fast Tansient Sensors - Q2 - Coursework 2
% B126949 - Tom Young

%% Pre - Cursor
clear all
clc

%% Constants
% Using 1&9 give constants as O-O 
% d = 0.14*10^-3; %mm
% D = 4*10^-2;    %cm
% L = 10*10^-2;  %cm
% p = 0.8*10^-3;  %mm
d = 0.25*10^-3; %mm
D = 4*10^-2;    %cm
L = 9.5*10^-2;  %cm
p = 0.8*10^-3;  %mm
rho = 1.72*10^-8;  %Ohm-Meter
a = d/2; %radius mm

%% Part A
% Caculate the DC resistance
[DCResis, Coil_length] = rhelical(L,d,p,rho,D);
DCResis

%% Part B
% Estimate the resistance at 1MHz
delta = dskin(rho,1*10^6);
Sskin = 2.*a.*pi.*delta.*(1-(delta./(2.*a)));
Rskin = (Coil_length.*rho)./Sskin;
RFreq = DCResis.*Rskin.*(1+((2.*(a^2))./(p^2)))

%% Part C
% Draw a graphical representation of the resistance variation with 
% frequency up to a frequency of 1GHz.
Rcf = critf(rho,a);
% Loop to calculate resistance with frequency
count = 100;
RT = zeros(count);
Freq = logspace(0,7,count);
for ln = 1:1:count;
    if Freq(ln) >= Rcf 
        delta = dskin(rho,Freq(ln));
        Sskin = 2.*a.*pi.*delta.*(1-(delta./(2.*a)));
        Rskin = (Coil_length.*rho)./Sskin;
        RT(ln) = DCResis.*Rskin.*(1+((2.*(a^2))./(p^2)));
    else
        RT(ln) = DCResis;
    end
end
% Plot data
figure
semilogx(Freq,RT./DCResis,'b','linewidth',2)
%semilogx(Freq,RT,'b','linewidth',2)
grid on
xlabel('Frequency')
ylabel('$${F(f,R)\over F(0,0) }$$','Interpreter','Latex')
xlim([0 10*10^6])
ylim([1 inf])
title('Resistance change with Frequency')



%% Part D
% Written
