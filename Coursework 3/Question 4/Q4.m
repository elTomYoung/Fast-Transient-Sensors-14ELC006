%% Fast Tansient Sensors - Q4 - Coursework 3
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
%Global constants
u0 = 4*pi*10^-7;  % H/m
e0 = 8.85*10^-12; % F/m
%Bank Constants
Cb = 100*10^-6;
Trans_width = 40*10^-2;
Vo = 30*10^3;
Lb = 50*10^-9;
Rb = 0;
Q = 0;
I = 1;
%Probe constants
Pr_tunnel = 15*10^-3;
Pr_diameter = 3*10^-3;
Pr_MaxV = 200;
Pr_area  = pi.*(Pr_diameter./2)^2

%% Current Discharge
%Bank Current Discharge
dI = (Vo-(Q./Cb)-(Rb.*I))./Lb
%Peak Mag Flux Change
l = 40*10^-2;
r = 0;
a = Pr_tunnel./2;
z = 0;
Bz_pre = (u0.*I)./(4.*pi.*l);
y = a./l;
d = r./a;
zd = z./(l./2);
axial_flux = @(x) ((1-(d.*cos(x)))./(1.+(d.^2)-(2.*d.*cos(x)))).*(((1-zd)./sqrt((y.^2).*(1.+(d.^2)-(2.*d.*cos(x)))+((1-zd).^2)./4))+((1.+zd)./sqrt((y.^2).*(1.+(d.^2)-(2.*d.*cos(x)))+((1-zd).^2)./4)));
Bz = Bz_pre.*integral(@(x)axial_flux(x),0,pi);
dB = Bz.*dI
Nt = Pr_MaxV./(Pr_area.*dB)
z = 0:1*10^-6:20*10^-3;
% Bz1 = zeros(1,length(z)); 
% for n = 1:length(z)
%     Bz1(n) = baxial(a,r,z(n),l,I);
% end
Bz1 = baxial(a,r,z,l,I);
plot(z,Bz1)















