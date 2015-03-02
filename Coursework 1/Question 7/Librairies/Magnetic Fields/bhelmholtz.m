function [ bhelmholtz ] = bhelmholtz( coil_radius, coil_distance, current, z_point)
%bhelmholtz Magnetic field strength at point P from a Helmholtz coil pair 
%along axis.
%
%   Magnetic field strength at point P(zp) from the center of helmholtz 
%   coil pair of radius a carrying current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    bhelm_pre = (u_0*coil_radius^2*current)/2;
    bhelmholtz = bhelm_pre*((1/((a^2+(z_point+(coil_distance/2)^2))^(3/2)))+(1/((a^2+(z_point-(coil_distance/2)^2))^(3/2))));
end
