function [ bhelicalml ] = bhelicalml( inner_radius, outer_radius, current, coil_turns, coil_length, z_point )
%bhelicalml Magnetic field strength at point P from a thin helical coil along 
%axis.
%
%   Magnetic field strength at point P(zp) along the axis of a thin helical
%   coil from origin of L = 0, of radius a, turns N and length L carrying 
%   current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    if z_point >= coil_length
        disp('Incorrect use of function "bhelicalml"');
        bhelicalml = 0;
    else
        h2 = z_point;
        h1 = coil_lenth - h2;
        bhel_pre = (u_0*coil_turns*current)/(2*coil_length);
        bhel_logh1 = log((outer_radius + sqrt(outer_radius^2 + h1^2))/(inner_radius + sqrt(inner_radius^2 + h1^2)));
        bhel_logh2 = log((outer_radius + sqrt(outer_radius^2 + h2^2))/(inner_radius + sqrt(inner_radius^2 + h2^2)));
        bhelicalml = bhel_pre*(((h1/(outer_radius-inner_radius))*bhel_logh1)+((h2/(outer_radius-inner_radius))*bhel_logh2));
    end
end
