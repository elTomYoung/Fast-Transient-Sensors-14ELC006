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
CGap = csparkgap(SgSpRadius,SgDist,100)

%% Voltage Loss
VLoss = (CStray/(CGap+CStray));
VLossPerCent = 100-(VLoss*100)

%% Stages
VPrevStage = CMarxCharge;
VCStage = 0;
VTotal = 0;
Ns = 0;
while VTotal < VPeak
    VCStage = VPrevStage*VLoss;
    VTotal = VCStage+VTotal
    VPrevStage = VCStage;
    Ns = Ns + 1;
end %12

%% Charge Current, feed forward, power


%% Time dependance of load
