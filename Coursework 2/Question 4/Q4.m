%% Fast Tansient Sensors - Q4 - Coursework 2
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
C = 0.1*10^-6;
V0 = 30*10^3;
Im1 = 10*10^3;
tm1 = 250*10^-9;

%% Part A
% Written

%% Part B
% Written

%% Part C
% From the equations given make an accurate calculation of R and L.
% F(gamma) = CV0*f(gamma)*g(gamma)
gamma = -1:0.01:1;
F = C.*V0.*f(gamma).*g(gamma)-(tm1*Im1);
% Plot
figure 
plot(gamma,F,'linewidth',2)
grid on
xlabel('\gamma')
ylabel('F(\gamma)')
title('Graph of F(\gamma) for \gamma =-1:1')
% From datapoint method at F(gamma) = 0, gamma = 0.3421
gamma = 0.3421;
% Calculate L using Im1 equation and R using gamma equation.
L = ((V0.*sqrt(C).*g(gamma))./Im1).^2
R = 2.*gamma.*sqrt(L./C)


%% Part D
%  Calculate second peak and time using c
%gamma = 0.5*R*sqrt(C/L)
omega = (1/sqrt(L*C)).*sqrt(1-(gamma^2))
t = 0:1*10^-10:0.6*10^-5;
Im = (V0./(omega.*L)).*sin(omega.*t).*exp(-(R/(2*L)).*t);
tm = (sqrt(L.*C)).*((1./sqrt(1-(gamma.^2))).*asin(sqrt(1-(gamma.^2))));
figure
plot(t.*10^6,Im./(1*10^3),'Linewidth',2)
grid on
xlabel('Time(\mus)')
ylabel('I(kA)')
title('Discharge Current for 30kV V_{0}')
% Find Im2 and Tz
Im2 = min(Im);
Tzidx = find(Im == min(Im));
Tz = t(Tzidx);
T = 2*Tz;
Lest = (T^2)./(4.*(pi^2).*C)
Rest = (-2./pi).*(sqrt(Lest./C)).*(log(abs(Im2)./Im1))

%% Part E 
% Repeat C and D from the following conditions.
C2 = 54*10^-6;
V02 = 27*10^3;
Im12 = 1*10^6;
tm12 = 1.7*10^-6;
% Repeat from part C
gamma = -1:0.01:1;
F = C.*V0.*f(gamma).*g(gamma)-(tm1*Im1);
% Plot
figure 
plot(gamma,F,'linewidth',2)
grid on
xlabel('\gamma')
ylabel('F(\gamma)')
title('Graph of F(\gamma) for \gamma =-1:1')
% From datapoint method at F(gamma) = 0, gamma = 0.1464
gamma_c = 0.1464;
% Calculate L using Im1 equation and R using gamma equation.
L2 = ((V02.*sqrt(C2).*g(gamma_c))./Im1).^2
R2 = 2.*gamma_c.*sqrt(L2./C2)
% Repeat from Part D
omega = (1/sqrt(L2*C2)).*sqrt(1-(gamma_c^2))
t2 = 0:1*10^-6:6*10^-3;
Im_2 = (V02./(omega.*L2)).*sin(omega.*t2).*exp(-(R2/(2*L2)).*t2);
tm2 = (sqrt(L2.*C2)).*((1./sqrt(1-(gamma_c.^2))).*asin(sqrt(1-(gamma_c.^2))));
figure
plot(t2.*10^3,Im_2./(1*10^3),'Linewidth',2)
grid on
xlabel('Time(ms)')
ylabel('I(kA)')
title('Discharge Current for 27kV V_{0}')
% Find Im2 and Tz
% First peak
Im_2_max = max(Im_2);
T1idx = find(Im_2 == Im_2_max);
T1 = t2(T1idx);
% Second peak
Im_2_min = min(Im_2);
Tzidx = find(Im_2 == Im_2_min);
Tz = t(Tzidx);
T = 2*Tz;
Lest2 = (T^2)./(4.*(pi^2).*C2)
Rest2 = (-2./pi).*(sqrt(Lest./C2)).*(log(abs(Im_2_min)./Im_2_max))

%% Part F
% Written