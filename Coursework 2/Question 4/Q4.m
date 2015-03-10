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
%Lt = ((tm1./f(gamma))^2).*(1./C)
R = 2.*gamma.*sqrt(L./C)
% Gives values of;
%   L = 36.98 H
%   R = 3.56*10^-5 Ohm / 35.6 uOhm


%% Part D
%  Calculate second peak and time using c
%gamma = 0.5*R*sqrt(C/L)
omega = (1/sqrt(L*C)).*sqrt(1-(gamma^2))
t = 0:1*10^-10:0.6*10^-5;
Im = (V0./(omega.*L)).*sin(omega.*t).*exp(-(R/(2*L)).*t)./(1*10^3);
tm = (sqrt(L.*C)).*((1./sqrt(1-(gamma.^2))).*asin(sqrt(1-(gamma.^2))));
figure
plot(t,Im)
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

% %% Part E 
% % Repeat C and D from the following conditions.
% C = 54*10^-6;
% V0 = 27*10^3;
% Im1 = 1*10^6;
% tm1 = 1.7*10^-6;
% % Repeat from part C
% gamma = -1:0.01:1;
% F = C.*V0.*f(gamma).*g(gamma)-(tm1*Im1);
% % Plot
% figure 
% plot(gamma,F,'linewidth',2)
% grid on
% xlabel('\gamma')
% ylabel('F(\gamma)')
% title('Graph of F(\gamma) for \gamma =-1:1')
% % From datapoint method at F(gamma) = 0, gamma = 0.1464
% gamma = 0.1464;
% % Calculate L using Im1 equation and R using gamma equation.
% L = (V0.*sqrt(C).*g(gamma)).^2
% R = 2.*gamma.*sqrt(C./L)
% % Gives values of;
% %   L = 25.8 kH
% %   R = 1.3388*10^-5 Ohm / 13.39uOhm
% % Repeat from Part D
% omega = (1/sqrt(L*C)).*sqrt(1-(gamma^2))
% t = 0:0.01:1;
% Im = (V0./(omega.*L)).*sin(omega.*t).*exp(-(R/(2*L)).*t);
% tm = (sqrt(L.*C)).*((1./sqrt(1-(gamma.^2))).*asin(sqrt(1-(gamma.^2))));
% figure
% plot(t,Im)
% title('Part E')
% 
% %% Part F
% % Written