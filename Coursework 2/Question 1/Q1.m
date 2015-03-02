%% Fast Tansient Sensors - Q1 - Coursework 2
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using 1&9 give constants as O-O 
a = 3.5*10^-3;  %mm
b = 10.5*10^-3; %mm
La = 22*10^-3;  %mm
Lb = 12*10^-3;  %mm
Lc = 50*10^-3;  %mm
rho = 7.2*10^-7;  %Ohm-Meter

%% Part A 
% Calculate the DC Resistance of the conductor
% Resistence of small wire
R1 = rwire(rho,La,a);
% Resistence of large wire
R2 = rwire(rho,Lb,b);
% Resistance of conical section
RC_DC = rconical(a,b,Lc,rho);
% Total resistance
DCResis = R1 + R2 + RC_DC

%% Part B
% Draw a graphical representation of the conductor resistance variation
% with frequency up to 1GHz
alpha = atan((b-a)/Lc);
% Calculate critical frequencies and DC resistances
%       First section
R1cf = critf(rho,a);
%       Conical section
N = 1000;
Lc_step = Lc/N;
for n = 1:1:N
   h(n) = Lc_step*n.*tan(alpha)+a;
   RCcf(n) = critf(rho,h(n));   
   RCdc(n) = rwire(rho,Lc_step,h(n));
end
%       End Section
R2cf = critf(rho,b);
% Loop to calculate resistance with frequency
RFreq=zeros(50);
Freq = logspace(0,9);
for ln = 1:1:50;
    RC = 0;
    %   First Section
    if Freq(ln) >= R1cf 
        delta = dskin(rho,Freq(ln));
        Sskin = 2.*a.*pi.*delta.*(1-(delta./(2.*a)));
        RF = (La.*rho)./Sskin;
        %RF = R1.*(a./(2.*delta));
    else
        RF = R1;
    end
    %   Conical Section
    for n = 1:1:N
        if Freq(ln) >= RCcf(n) 
           delta = dskin(rho,Freq(ln));
           Sskin = 2.*h(n).*pi.*delta.*(1-(delta./(2.*h(n))));
           RC(n) = (Lc_step.*rho)./Sskin;
           %RC(n) = RCdc(n).*(h(n)./(2.*delta));
        else
           RC(n) = RCdc(n); 
        end
    end
    %   End Section
    if Freq(ln) >= R2cf 
        delta = dskin(rho,Freq(ln));
        Sskin = 2.*b.*pi.*delta.*(1-(delta./(2.*b)));
        RE = (Lb.*rho)./Sskin;
        %RE = R2.*(b./(2.*delta));
    else
        RE = R2;
    end
    % Total resistance
    RFreq(ln) = (RE+RF+sum(RC));
end

% Plot data
loglog(Freq,RFreq./DCResis,'b','linewidth',2)
grid on
xlabel('Frequency')
ylabel('Ratio of ressitance at frequency to DC resistance. f(f,R) / f(0,0)')
xlim([0 1*10^9])
title('Resistance change with Frequency')