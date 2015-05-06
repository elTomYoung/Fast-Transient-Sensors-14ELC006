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
major_radius = 15*10^-3;
minor_radius = 0.5*10^-3;
wire_diameter = 2*minor_radius;
N = 5; %5-10 turns
copper_rho = 1.7*10^-8;
%Current Viewing Resistor
Rcvr = 50; %Matches cable impedence
%Resistance
coil_length_est = pi*major_radius*2*N;
coil_area = pi*minor_radius^2;
RCoil_resistance = copper_rho.*(coil_length_est./coil_area);
%Inductance
RCoil_inductance = indhelical(N,major_radius,coil_length_est);

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
%Differential Magnetic Flux
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
rogowski_current = @(x,Rrt,Lr,Cb,Lb,Rb,Vo) exp((Rrt./Lr).*x).*(k.*(Vo./((1./sqrt(Lb.*Cb)).*Lb).*(((1./sqrt(Lb.*Cb)).*exp((-1.*(Rb./(2.*Lb)).*x)).*cos((1./sqrt(Lb.*Cb)).*x))+((-1.*(Rb./(2.*Lb))).*exp((-1.*(Rb./(2.*Lb)).*x)).*sin((1./sqrt(Lb.*Cb)).*x)))));
RIntegral = integral(@(x)rogowski_current(x,Rrt,Lr,Cb,Lb,Rb,Vo),0,10*10^-9);
t2 = 0:1*10^-10:10*10^-9;
Rogowski_Current = (exp(-(Rrt./Lr).*t2)./Lr).*RIntegral;
%Method 1
dRogowski_Current_prefix = (exp(-(Rrt./Lr).*t2)./Lr).*exp((Rrt./Lr).*t2).*dflux(1:length(t2));
dRogowski_Current = dRogowski_Current_prefix + (RIntegral.*((-Rrt./Lr).*exp(-(Rrt./Lr).*t2)./Lr));
%Method 2
rc = symfun((exp(-(Rrt./Lr).*x)./Lr).*RIntegral, [x]);
y = subs(diff(rc(x)),t2);
%Plot
figure('name','Rogowski Coil Voltage')
subplot(211)
plot(t2.*10^9,y.*Lr,'b','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('V_{R} (V)')
title('Rogowski Coil Voltage')
subplot(212)
plot(t2.*10^9,dRogowski_Current.*Lr,'r','Linewidth',2)
grid on
xlabel('Time (ns)')
ylabel('V_{R} (V)')
title('Rogowski Coil Voltage')