%% Fast Tansient Sensors - Q1 - Coursework 3
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
%Global constants
u0 = 4*pi*10^-7;  % H/m
e0 = 8.85*10^-12; % F/m
%Wire constants
evan_rho = 1.38*10^-6; %Ohm/m
evan_heat = 435; %J/kg/K
evan_dens = 8100; %kg/m^3;
%Generator Constants
Ns = 20;
CStage = 40*10^-9;
V0 = 25*10^3;
RStage = 10*10^-3;
RLoad = 10*10^3;
CLoad = 250*10^-9;

%% Load Voltage
t=0:1*10^-10:1*10^-6;
VMax = V0.*Ns;
RTotal = RStage.*Ns;
CTotal = CStage./Ns;
Beta1 = 1./(RTotal.*CLoad);
Beta2 = 1./(RLoad.*CTotal);
VLoad=(VMax/((Beta1-Beta2)*RTotal*CLoad))*(exp(-Beta2*(t))-exp(-Beta1*(t)));
rt = risetime(VLoad)./10^10;
VMaxPeak = max(VLoad)./10^3;
fband = (0.35)./rt;
%Plot VLoad
plot(t.*10^6,VLoad./10^3,'Linewidth',2)
grid on
str = sprintf('Marx Generator Output Voltage for N_{s} = %d and T_{RISE} = %.2fns, V_{peak} = %.2fkV',Ns,rt.*10^9,VMaxPeak);
title(str);
ylabel('V (kV)');
xlabel('Time (\mus)');
%Voltage Sensor
rtvs = rt./5;
fbsens = (0.35)./rtvs;

%% Voltage Divider
%Low voltage arm
Zc = 50;
Z1 = Zc;
Z2 = Zc;
Z = Zc/2;
Tlv = 0;
%High voltage arm
Zhv = (((VMaxPeak*10^3)/80)*Zc)-Zc;
%Resistive Column
ColumnHeight = (VMaxPeak./5).*10^-2;
%Wire radius from bandwidth requirement
wire_radius = 12*10^-6;
rmandrel = 0.05;
wire_length = ((pi*(wire_radius)^2)*Zhv)/evan_rho;
wirel = wire_length*2;
Nt = wirel./(pi.*rmandrel.*2);
twirelength = wire_length*4;
%Energy
t=0:1*10^-10:300*10^-6;
VLoad=(VMax/((Beta1-Beta2)*RTotal*CLoad))*(exp(-Beta2*(t))-exp(-Beta1*(t)));
figure
plot(t.*10^6,VLoad./10^3,'Linewidth',2)
grid on
str = sprintf('Marx Generator Output Voltage for N_{s} = %d and T_{RISE} = %.2fns, V_{peak} = %.2fkV',Ns,rt.*10^9,VMaxPeak);
title(str);
ylabel('V (kV)');
xlabel('Time (\mus)');
% x0 = interp1(VLoad,t,0)
%Energy
tmax = 130*10^-6;
Q = ((tmax*(max(VLoad)^2))/(2*Zhv));
%Wire Mass
wire_vol = (pi*(wire_radius^2))*twirelength; %m^3
wire_mass = wire_vol*evan_dens; %kg
%Temperature
deltaT = Q./(wire_mass.*evan_heat);
% Capacitance was 16pF with graded column made of aluminium
cHV = 16*10^-12
%Connecting Cable
%Chosen wire length of 2m
width = 1;
connecting_wire_radius = 5*10^-3;
indSys = indpoly('Rectangle',width,ColumnHeight,connecting_wire_radius)
indConnector = indpoly('RoundWire',width,connecting_wire_radius)/4
%Transfer functiona and response time from notes
rd_sys = 1.2*sqrt(indSys./cHV);
rd_connector = 1.2*sqrt((indConnector.*4)./cHV);
rtvs
Ttotal = (rd_sys.*cHV)+(rd_connector.*cHV)
% If Tconn is less than T from part a then system is good.
% Change cable to one which gives a negative time response
% therfore total time tresponse is shorter. See elements of
% voltage networks applied to transient sensors.

%% Print to file
fileID = fopen('Q1.txt','w');
fprintf(fileID,'Load Voltage Characteristics\r\n');
fprintf(fileID,'Peak Voltage = %.2fkV\r\n',VMaxPeak);
fprintf(fileID,'Rise Time = %.2fns\r\n',rt.*10^9);
fprintf(fileID,'Bandwidth = %.2fMHz\r\n\r\n',fband./10^6);
fprintf(fileID,'Voltage Sensor\r\n');
fprintf(fileID,'For 2 percent accuracy, requires ratio of 5:1 giving;\r\n');
fprintf(fileID,'Rise Time = %.2fns\r\n',rtvs.*10^9);
fprintf(fileID,'Bandwidth = %.2fMHz\r\n\r\n',fbsens./10^6);
fprintf(fileID,'Low Voltage Arm\r\n');
fprintf(fileID,'Chosen design is a coaxial cable with;\r\n');
fprintf(fileID,'Z1 = 50, ');
fprintf(fileID,'Z2 = 50, ');
fprintf(fileID,'Z = 25\r\n');
fprintf(fileID,'T_{lv} = 0\r\n\r\n');
fprintf(fileID,'High Voltage Arm\r\n');
fprintf(fileID,'Using the attenuation factor with a z of %.2f Ohms gives\r\n a high voltage arm resistor value of %.0f kOhms\r\n',Zc,Zhv.*10^-3);
fprintf(fileID,'with a height of %.2fcm.\r\n',ColumnHeight.*10^2);
fprintf(fileID,'For a wire radius of %.0fmicrom and a madrel radius of %0.2fcm, \r\n',wire_radius.*10^6,rmandrel.*10^2);
fprintf(fileID,'%.0fm of wire is required. This gives a total turns of %0f.\r\n',twirelength,Nt);
fprintf(fileID,'Under the discharge from the Marx generator the temeprature\r\n');
fprintf(fileID,'increase in the wire is %.2fdegrees\r\n\r\n',deltaT);
fprintf(fileID,'\r\n');
fprintf(fileID,'Using the grading method described in figure 3\r\n');
fprintf(fileID,'the capacitance is approximately %.0fpF\r\n',cHV.*10^12);
fprintf(fileID,'\r\n');
fclose(fileID);