function [ proxyim ] = proxyim( radius, pitch )
%DSKIN Calculates skin effect
%   Calculates the skin effect depth at frequency f of a material with
%   resistivity rho.

%% Constants
    u_0 = 4*pi*10^-7;

%% Equations
    proxyim = 1+(2.*(radius^2))./(pitch^2);

end
