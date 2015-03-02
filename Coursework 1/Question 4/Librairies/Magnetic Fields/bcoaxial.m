function [ bcoaxial ] = bcoaxial( radius, current, inner_radius, outer_radius )
%bcoaxial Magnetic field strength inside or between an infinitely long
%coaxial cable.
%   Magnetic field strength of an infinitely long coaxial cable where, radius is
%   the radius to calcualte B at, current is the current, a is the inner
%   conductor radius and b is the out conductor radius.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    if radius <= inner_radius        
        % Inside conductor
        bcoaxial = (u_0*radius*current)/(2*pi*(inner_radius^2));
    elseif radius <= outer_radius
        % Between conductors
        bcoaxial = (u_0*current)/(2*pi*radius);
    else
        % Outside conductors
        bcoaxial = 0;
    end 
end

