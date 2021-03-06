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
Cb = 1*10^-6;
Rb = 10*10^-3;
Lb = 50*10^-9;
Vo = 40*10^3;
%Rod Diameter
Rd = 10*10^-3;

%% Current Discharge
t = 0:1*10^-10:25*10^-6;
[Current_Discharge, Diff_Current_Discharge, damping_string] = dcdisch(Vo,Lb,Cb,Rb,t);
figure('name','RLC Current Discharge')
plot(t.*10^6,Current_Discharge.*10^-3,'Linewidth',2)
grid on
xlabel('Time (\mus)')
ylabel('Current (kA)')
title(['Current Discharge for an ', damping_string ,' RLC Circuit'])
figure('name','RLC Differential Current Discharge')
plot(t.*10^6,Diff_Current_Discharge.*10^-9,'Linewidth',2)
grid on
xlabel('Time (\mus)')
ylabel('Current/Time (GA/s)')
title(['Differential Current Discharge for an ', damping_string ,' RLC Circuit'])

%% Probe Design
%Coil Parameters
major_radius = 20*10^-3
minor_radius = 2*10^-3
wire_radius = 1*10^-3
wire_diameter = 2*wire_radius;
N = 10 %5-10 turns
copper_rho = 1.7*10^-8;
%Current Viewing Resistor
Rcvr = 50 %matches cable impedence
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
RCoil_inductance = Induct_pre*Induct_pre2
%Resistance
freq = 1/(2*pi*sqrt(Lb*Cb));
RCoil1 = N/(pi*wire_diameter);
RCoil2 = sqrt((copper_rho*pi*freq*u0)*((p^2)+((2*pi*minor_radius)^2)));
RCoil_resistance = RCoil1*RCoil2

%% Magnetic flux
%Magnetic flux time rate-of-change
k = u0.*N.*(major_radius-sqrt((major_radius^2)-(minor_radius^2)));
flux = k.*Current_Discharge;
figure('name','Magnetic Flux')
plot(t.*10^6,flux.*10^6,'Linewidth',2)
grid on
xlabel('Time (\mus)')
ylabel('Magneic Flux (\muT)')
title(['Magnetic flux for an ', damping_string ,' RLC Circuit'])
% Differential Magnetic Flux
dflux = k.*Diff_Current_Discharge;
figure('name','Differntial Magnetic Flux')
plot(t.*10^6,dflux,'Linewidth',2)
grid on
xlabel('Time (\mus)')
ylabel('Differential Magneic Flux (T/s)')
title(['Magnetic flux for an ', damping_string ,' RLC Circuit'])

%% Rogowski Coil Current
Rrt = RCoil_resistance + Rcvr;
Lr = RCoil_inductance;
omega = sqrt((1./(Lb.*Cb))-((Rb./(2.*Lb))^2));
rogowski_current = @(x) exp((Rrt./Lr).*x).*(k.*(Vo./(omega.*Lb).*((omega.*exp(-1.*(Rb./(2.*Lb)).*x).*cos(omega.*x))-((Rb./(2.*Lb)).*exp(-1.*(Rb./(2.*Lb)).*x).*sin(omega.*x)))));
t2 = 0:1*10^-10:10*10^-9;
RIntegral = zeros(0,length(t2));
for n=1:length(t2)
    RIntegral(n) = integral(@(x)rogowski_current(x),0,t2(n));    
end
Rogowski_Current = (exp(-(Rrt./Lr).*t2)./Lr).*RIntegral;
dRogowski_Current_prefix = (exp(-(Rrt./Lr).*t2)./Lr).*exp((Rrt./Lr).*t2).*(k.*(Vo./(omega.*Lb).*((omega.*exp(-1.*(Rb./(2.*Lb)).*t2).*cos(omega.*t2))-((Rb./(2.*Lb)).*exp(-1.*(Rb./(2.*Lb)).*t2).*sin(omega.*t2)))));
dRogowski_Current = dRogowski_Current_prefix + (RIntegral.*((-Rrt.*exp((-Rrt./Lr).*t2))./(Lr^2)));
figure('name','Rogowski Coil Voltage')
plot(t2.*10^9,Rogowski_Current,'b','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('I_{R} (A)')
title('Rogowski Coil Current')
figure('name','Differential Rogowski Coil Voltage')
plot(t2.*10^9,dRogowski_Current.*10^-9,'b','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('dI_{R}/dt (GA/s)')
title('Differential Rogowski Coil Current')
figure('name','Rogowski Coil Characteristics')
hold on
plot(t2.*10^9,Rogowski_Current.*Rrt,'b','Linewidth',2)
plot(t2.*10^9,dRogowski_Current.*Lr,'r','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('V_{R} (V)')
title('Rogowski Coil Voltage')
legend('R_{R}I_{R}','L_{R}dI_{R}/dt')
hold off

%% Input Voltage
%Differential Magnetic Flux
Vin = k.*Diff_Current_Discharge;
figure('name','Input Voltage')
plot(t.*10^6,Vin,'Linewidth',2)
grid on
xlabel('Time (\mus)')
ylabel('Voltage (V)')
title('Rogowski Coil Output Voltage')
%% Oscilloscope Voltage
% Integrator Design
Ri = 50*10^-3;
Ci = 500*10^-9;
tau = Ri.*Ci;
Vosc = (Rogowski_Current.*k)./tau;
figure('name','Rogowski Coil Voltage')
plot(t2.*10^9,Vosc,'b','Linewidth',2)
Voutp = max(Vosc);
grid on
xlabel('Time (ns)')
ylabel('Voltage (V)')
str = sprintf('Integrator Circuit Output Voltage with peak: %.1fV',Voutp);
title(str)
