%% Fast Tansient Sensors - Q5 - Coursework 2
% B126949 - Tom Young
%% Pre - Cursor
clear all
clc
%% Constants
Z0 = 50; % 50 Ohms
V1 = 5; % 5V
% Setup delta
delta = [0/4,1/4,2/4,3/4,4/4];

%% Part A
% i)
Zl1 = 50;
Pl1 = (Zl1-Z0)/(Zl1+Z0);
V1l = V1*Pl1;
V1l = [0,0,V1l,0,0];

% ii)
Zl2 = 20;
Pl2 = (Zl2-Z0)/(Zl2+Z0);
V2l = V1*Pl2;
V2l = [0,0,V2l,0,0];

% iii)
Zl3 = 75;
P3 = (Zl3-Z0)/(Zl3+Z0); % 0.2
V3l = V1*P3; % 1V
V3l = [0,0,V3l,0,0];

% Plot
figure
% i)
subplot(3,1,1)
bar(delta,V1l)
title('Z_{l} = 50\Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-2.5, 2.5])
xlim([0,1])
grid on
% ii)
subplot(3,1,2)
bar(delta,V2l)
title('Z_{l} = 20\Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-2.5, 2.5])
xlim([0,1])
grid on
% iii)
subplot(3,1,3)
bar(delta,V3l)
title('Zload = 75 Ohms')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-2.5, 2.5])
xlim([0,1])
grid on

%% Part B
V0 = 5;
delta = [1,2,3,4];
% i)
Pl1 = (Zl1-Z0)/(Zl1+Z0);
V1a = V0; %
V1b = V1a*Pl1;
V1c = V1b*Pl1;
V1d = V1c*Pl1;
V1 = [V1a, V1b, V1c, V1d];
V1vals = strtrim(cellstr(num2str(V1(:),'%.2fV')));


% ii)
Pl2 = (Zl2-Z0)/(Zl2+Z0);
V2a = V0;
V2b = V2a*Pl2;
V2c = V2b*Pl2;
V2d = V2c*Pl2;
V2 = [V2a, V2b, V2c, V2d];
V2vals = strtrim(cellstr(num2str(V2(:),'%.2fV')));

% iii)
P3 = (Zl3-Z0)/(Zl3+Z0);
V3a = V0;
V3b = V3a*P3;
V3c = V3b*P3;
V3d = V3c*P3;
V3 = [V3a, V3b, V3c, V3d];
V3vals = strtrim(cellstr(num2str(V3(:),'%.2fV')));

% Plot graph
figure
% i)
subplot(3,1,1)
bar(delta,V1)
text(delta,V1,V1vals,'VerticalAlignment','baseline');
title('Z_{l} = 50\Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-5, 5])
grid on
% ii)
subplot(3,1,2)
bar(delta,V2)
text(delta,V2,V2vals,'VerticalAlignment','baseline');
title('Z_{l} = 20\Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-5, 5])
grid on
% iii)
subplot(3,1,3)
bar(delta,V3)
text(delta,V3,V3vals,'VerticalAlignment','baseline');
title('Z_{l} = 75\Omega')
ylabel('Volts (V)')
xlabel('Time (\delta)')
ylim([-5, 5])
grid on