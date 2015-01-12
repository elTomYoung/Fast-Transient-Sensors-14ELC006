%% Fast Tansient Sensors - Q5
% B126949 - Tom Young


%% Pre - Cursor
clear all
clc

%% Constants
% Using B126949 give constants as O-O
u_0 = 4*pi*10^-7;
D2 = 40*10^-3;
H1 = 20*10^-3;
d = 0.2*10^-3;
L = 300*10^-3;
H2 = 100*10^-3;
delta = 45*10^-3;
beta = 35*10^-3;
alpha = 45;
S = H2-H1;

%% Section A - Large Rectangle
w = H1 + H2;
l = L + beta;
L_lg_rect = indparplates(L+beta,d,H1+H2);

%% Section B - Variable Width
s_tri_base = ((H2-H1)/2)*tand(45);
L_var_rect = indparplates(s_tri_base,d,H2,H1);

%% Section C - Small Rectangle
L_sm_rect = indparplates(delta,d,H1);

%% Section D - Coil
L_coil = indscoil(D2/2,H1);

%% Coil Mutual
N_outer = 10;
N_inner = N_outer;
% Pre-allocate mindK
mindk = zeros(1,N_outer);
for k_loop = 0:1:N_outer-1
   j_loop = 0:1:N_inner-1;
   Dkj = H1-(k_loop.*(H1./N_outer))+S+(j_loop.*(H1./N_inner));
   mindk(k_loop+1) = sum(mindcoil(D2/2,D2/2,Dkj));
end
tmcoil = sum(mindk);
%% Total Self Inductance
L_total = L_lg_rect+(2*L_var_rect)+(2*L_sm_rect)+(2*L_coil)+tmcoil
