function [ bhelicalvp ] = bhelicalvp( coil_radius, coil_length, current, z_point, small_pitch, large_pitch)
%bhelical Magnetic field strength at point P from a thin helical coil along 
%axis with a linear varying pitch.
%
%   Magnetic field strength at point P(zp) along the axis of a thin helical
%   coil of radius a, turns N and length L carrying current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    bhel_pre = (u_0*coil_radius^2*current)/(4*pi);
    bhelicalvp = bhel_pre*(((z_point+(coil_length/2))/sqrt(coil_radius^2+(z_point+(coil_length/2))^2))-((z_point-(coil_length/2))/sqrt(coil_radius^2+(z_point-(coil_length/2))^2)));
end
