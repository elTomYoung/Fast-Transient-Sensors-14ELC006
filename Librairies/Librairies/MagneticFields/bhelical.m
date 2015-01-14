function [ bhelical ] = bhelical( coil_radius, coil_turns, coil_length,current, z_point)
%bhelical Magnetic field strength at point P from a thin helical coil along 
%axis.
%
%   Magnetic field strength at point P(zp) along the axis of a thin helical
%   coil of radius a, turns N and length L carrying current I.
%

%% Constants
    u_0 = 4.*pi.*10.^-7;
%% Equations
    bhel_pre = (u_0.*coil_turns.*current)./(2.*coil_length);
    bhelical = bhel_pre.*(((z_point+(coil_length./2))./sqrt(coil_radius.^2+(z_point+(coil_length./2)).^2))-((z_point-(coil_length./2))./sqrt(coil_radius.^2+(z_point-(coil_length./2)).^2)));
end
