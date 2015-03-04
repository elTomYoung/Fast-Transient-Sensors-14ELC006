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
gamma = -100:0.01:100;
F = C.*V0.*f(gamma).*g(gamma)-(tm1*Im1);

% Plot
plot(gamma,F,'linewidth',2)
grid on
xlabel('\gamma')
ylabel('F(\gamma)')
title('Graph of F(\gamma) for \gamma =-100:100')
