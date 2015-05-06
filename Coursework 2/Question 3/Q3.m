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
u_0 = 4*pi*10^-7; % Free space permeability
e_0 = 8.85*10^-12; % Free space permittivity
f = 1*10^9; % 1GHz - frequency
Zi = 51; % 51 Ohms - Transmission line impedance

%% Quesiton
% Length of wire
Ri = dskin(Evan_rho,1*10^9)
WLength = (pi.*(Ri^2).*R)./Evan_rho % Over 30mm

% Conductor/Insulator ratio
er = 2.25; % Permittivity of polyethylene 
e = e_0*er; % 1.9912*10^-11

Ro = Ri*exp((Zi*2*pi)/sqrt(u_0/e_0))

count = 100;
RFreq=zeros(count);
Freq = logspace(0,12,count);
for ln = 1:1:count;
    if Freq(ln) >= f 
        delta = dskin(Evan_rho,Freq(ln));
        Sskin = 2.*Ri.*pi.*delta.*(1-(delta./(2.*Ri)));
        RFreq(ln) = (WLength.*Evan_rho)./Sskin;
    else
        RFreq(ln) = R;
    end
end

semilogx(Freq,RFreq./R,'b','linewidth',2)
grid on
xlabel('Frequency')
ylabel('$${F(f,R)\over F(0,0) }$$','Interpreter','Latex')
title('Resistance change with Frequency')
ylim([1 inf])