function [ dskin ] = dskin( resitivity, frequency )
%DSKIN Calculates skin effect
%   Calculates the skin effect depth at frequency f of a material with
%   resistivity rho.

%% Constants
    u_0 = 4*pi*10^-7;

%% Equations
    dskin = sqrt(resitivity./(frequency.*pi.*u_0));

end

