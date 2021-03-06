%% Fast Tansient Sensors - Q7 - Coursework 2
% B126949 - Tom Young
%% Pre - Cursor
clear all
clc
%% Constants
% Marx Constants
Freq = 10;
VPeak = 170*10^3;
TRise = 3*10^-9;
RLoad = 50;
CLoad = 2.5*10^-9;
CMarx = 20*10^-9;
CMarxCharge = 20*10^3;
EFBreak = 70*10^5; %kV/m
MarxSL = 50*10^-3;
MarxOD = 70*10^-3;
SgBreak = 20*10^3;
RSparkGap = 50*10^-3;
SgSpRadius = 2.5*10^-3;
SgDist = 0.5*10^-3;
% Other constants
P0 = 101.325*10^3;
E0 = 8.85*10^-12;
u_0 = 4*pi*10^-7;

%% Stray Capacitance
MarxCR = (VPeak/EFBreak)+(MarxOD/2);
CStray = ctrans(MarxCR,MarxOD/2)*MarxSL

%% Pressure Calculation
PressCalc_1 = 12260*exp((-2.1*10^-3)/SgSpRadius);
PressCalc_2 = (SgDist*10^3)^(0.49-(4*SgSpRadius)+288*(SgSpRadius^2));
P = (SgBreak*P0)/(PressCalc_1*PressCalc_2)

%% Spark Gap Self Capacitance
CGap = csparkgap(SgSpRadius,SgDist,15)

%% Voltage Loss
VLoss = (CStray/(CGap+CStray));
VLossPerCent = 100-(VLoss*100)

%% Stages
VPrevStage = CMarxCharge;
VCStage = 0;
VMax = 0;
Ns = 0;
while VMax < VPeak
    VCStage = VPrevStage*VLoss;
    VMax = VCStage+VMax;
    VPrevStage = VCStage;
    Ns = Ns + 1;
end
Ns

%% Charge Current, feed forward, power
%ffr
RFF = 0.1/(5*CMarx)
CCharge = (CMarx*CMarxCharge)*Ns;
I = CCharge/0.1
MaxPow = (I^2)*RFF


%% Time dependance of load
% Load voltage
RTotal = RSparkGap.*Ns;
CTotal = CMarx./Ns;
Beta1 = 1./(RTotal.*CLoad);
Beta2 = 1./(RLoad.*CTotal);
t=0:1*10^-10:5*10^-7;
VLoad=(VMax/((Beta1-Beta2)*RTotal*CLoad))*(exp(-Beta2*(t))-exp(-Beta1*(t)));
rt = risetime(VLoad)./10
% Plot
plot(t.*10^9,VLoad./10^3,'Linewidth',2)
grid on
str = sprintf('Marx Generator Output Voltage for N_{s} = %d and T_{RISE} = %.2fns',Ns,rt);
title(str);
ylabel('V (kV)');
xlabel('Time (ns)');
VMaxPeak = max(VLoad)

% Increase stages if necessary
while VMaxPeak<VPeak
    % Add stage
    Ns = Ns+1;
    % Re-calculate VMax
    VCStage = VPrevStage*VLoss;
    VMax = VCStage+VMax;
    VPrevStage = VCStage;
    % Re-calculate Power
    CCharge = (CMarx*CMarxCharge)*Ns;
    I = CCharge/0.1;
    MaxPow = (I^2)*RFF;
    % VLoad
    RTotal = RSparkGap.*Ns;
    CTotal = CMarx./Ns;
    Beta1 = 1./(RTotal.*CLoad);
    Beta2 = 1./(RLoad.*CTotal);
    VLoad=(VMax/((Beta1-Beta2)*RTotal*CLoad))*(exp(-Beta2*(t))-exp(-Beta1*(t)));
    VMaxPeak = max(VLoad);
    rt = risetime(VLoad)./10; %rise time in ns
end 
% Plot final result
figure
plot(t.*10^9,VLoad./10^3,'Linewidth',2)
grid on
str = sprintf('Marx Generator Output Voltage for N_{s} = %d and T_{RISE} = %.2fns',Ns,rt);
title(str);
ylabel('V (kV)');
xlabel('Time (ns)');
