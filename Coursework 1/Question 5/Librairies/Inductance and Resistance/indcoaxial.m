function [ indcoaxial ] = indcoaxial( inner_radius, outer_radius, cable_length, R1, r1, R2, r2 )
%indcoaxial Inductance of a coaxial cable
%
%   Inductance of a coaxial cable with either consistent inner and outer
%   radius or the inductance of varying radius r1 and r2.

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    %if statemnt for varying inner radius.
    if inner_radius == 0 || outer_radius == 0
        indcoax_pre = (u_0*cable_length)/(2*pi);
        indcoaxial = indcoax_pre*(((R2*log(R2)-R1*log(R1))/(R2-R1))-((r2*log(r2)-r1*log(r1))/(r2-r1)));
    else
        indcoaxial = ((u_0/(8*pi))+(u_0/(2*pi))*log(outer_radius/inner_radius))*cable_length;
    end
end
