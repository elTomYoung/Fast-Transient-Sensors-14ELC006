%% Fast Tansient Sensors - Q2 - Coursework 3
% B126949 - Tom Young

%% Pre - Cursor
clear all
clc
syms x

%% Constants
%Global constants
u0 = 4*pi*10^-7;  % H/m
e0 = 8.85*10^-12; % F/m
%Bank constants
Cb = 100*10^-9;
Rb = 50;
Lb = 25*10^-9;
Vo = 60*10^3;
%Rod Diameter
Rd = 10*10^-3;

%% Current Discharge
t = 0:1*10^-12:10*10^-9;
[Current_Discharge, Diff_Current_Discharge, damping_string] = dcdisch(Vo,Lb,Cb,Rb,t);
figure('name','RLC Current Discharge')
plot(t.*10^9,Current_Discharge.*10^-3,'Linewidth',2)
grid on
xlabel('t (ns)')
ylabel('Current (kA)')
title(['Current Discharge For ', damping_string ,' RLC Circuit'])
figure('name','RLC Differential Current Discharge')
plot(t.*10^9,Diff_Current_Discharge.*10^-9,'Linewidth',2)
grid on
xlabel('t (ns)')
ylabel('Current/t (GA/s)')
title(['Differential Current Discharge For ', damping_string ,' RLC Circuit'])

%% Probe Design
%Coil Parameters
major_radius = 50*10^-3;
minor_radius = 5*10^-3;
wire_radius = 2*10^-3;
wire_diameter = 2*wire_radius;
N = 20; %5-10 turns
copper_rho = 1.7*10^-8;
%Current Viewing Resistor
Rcvr = 50; %Matches cable impedence
%Pitch
p = (2.*pi.*major_radius)./N;
%Inductance
Induct_pre = u0.*minor_radius.*N;
Induct_sum0 = 0.0007*((log((2*pi*major_radius)/p))^0);
Induct_sum1 = 0.1773*((log((2*pi*major_radius)/p))^1);
Induct_sum2 = -0.0322*((log((2*pi*major_radius)/p))^2);
Induct_sum3 = 0.00197*((log((2*pi*major_radius)/p))^3);
Induct_sum = Induct_sum0 + Induct_sum1 + Induct_sum2 + Induct_sum3;
Induct_pre2 = (((pi*minor_radius)/p)+(log((2*p)/(wire_diameter)))-(5/4)-Induct_sum);
RCoil_inductance = Induct_pre*Induct_pre2;
%Resistance
freq = 1/(2*pi*sqrt(Lb*Cb));
% freq = 1./(Rb.*Cb);
RCoil1 = N/(pi*wire_diameter);
RCoil2 = sqrt((copper_rho*pi*freq*u0)*((p^2)+((2*pi*minor_radius)^2)));
RCoil_resistance = RCoil1*RCoil2;

%% Magnetic flux
%Magnetic flux t rate-of-change
k = u0.*N.*(major_radius-sqrt((major_radius^2)-(minor_radius^2)));
flux = k.*Current_Discharge;
figure('name','Magnetic Flux')
plot(t.*10^9,flux.*10^6,'Linewidth',2)
grid on
xlabel('t (ns)')
ylabel('Magneic Flux (\muT)')
title(['Magnetic flux for an ', damping_string ,' RLC Circuit'])
%Differential Magnetic Flux
dflux = k.*Diff_Current_Discharge;
figure('name','Differntial Magnetic Flux')
plot(t.*10^9,dflux.*10^-3,'Linewidth',2)
grid on
xlabel('t (ns)')
ylabel('Differential Magneic Flux (kT/s)')
title(['Magnetic flux for an ', damping_string ,' RLC Circuit'])

%% Rogowski Coil Current
Rrt = RCoil_resistance + Rcvr;
Lr = RCoil_inductance;
omegadot1 = (Rb./(2*Lb))^2;
omegadot2 = 1./(Lb*Cb);
omegadot = sqrt(omegadot1-omegadot2);
rogowski_current = @(x) exp((Rrt./(2.*Lr)).*x).*(k.*(Vo./(2.*omegadot.*Lb).*((exp(-1.*(Rb./(2.*Lb)).*x).*(omegadot.*exp(omegadot.*x)+omegadot.*exp(-omegadot.*x)))+(-1.*(Rb./(2.*Lb)).*exp(-1.*(Rb./(2.*Lb)).*x).*(exp(omegadot.*x)-exp(-omegadot.*x))))));
RIntegral = integral(@(x)rogowski_current(x),0,10*10^-9);
t2 = 0:1*10^-12:10*10^-9;
Rogowski_Current = (exp(-(Rrt./Lr).*t2)./Lr).*RIntegral;
dRogowski_Current_prefix = (exp(-(Rrt./Lr).*t2)./Lr).*exp((Rrt./Lr).*t2).*(k.*(Vo./(2.*omegadot.*Lb).*((exp(-1.*(Rb./(2.*Lb)).*t2).*(omegadot.*exp(omegadot.*t2)+omegadot.*exp(-omegadot.*t2)))+(-1.*(Rb./(2.*Lb)).*exp(-1.*(Rb./(2.*Lb)).*t2).*(exp(omegadot.*t2)-exp(-omegadot.*t2))))));
dRogowski_Current = dRogowski_Current_prefix + (RIntegral.*((-Rrt./Lr).*exp(-(Rrt./Lr).*t2)./Lr));
figure('name','Rogowski Coil Voltage')
hold on
plot(t2.*10^9,Rogowski_Current.*Rrt,'b','Linewidth',2)
plot(t2.*10^9,dRogowski_Current.*Lr,'r','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('V_{R} (V)')
title('Rogowski Coil Voltage')
legend('R_{R}I_{R}','L_{R}dI_{R}/dt')
hold off

%% Oscilloscope Voltage
Vosc = (Rogowski_Current.*Rrt);
figure('name','Rogowski Coil Voltage')
plot(t2.*10^9,Vosc,'b','Linewidth',2)
Voutp = max(Vosc);
grid on
xlabel('Time (ns)')
ylabel('Voltage (V)')
str = sprintf('Integrator Circuit Output Voltage with peak: %.1fV',Voutp);
title(str)