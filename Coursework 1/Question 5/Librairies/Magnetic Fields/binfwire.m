function [ binfwire ] = binfwire( radius, current, conductor_radius )
%binfwire Magnetic field strength inside or outisde of an infinitely long
%wire.
%
%   Magnetic field strength of an infinitely long wire. r is the radius to
%   calculate B at, I is the current and a is the radius of the conductor.
%   The radius of the conducer does not change the value of B outside.
%


%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    if radius <= conductor_radius        
        % Inside conductor
        binfwire = (u_0*radius*current)/(2*pi*(conductor_radius^2));
    else
        % Outside conductors
        binfwire = (u_0*current)/(2*pi*radius);
    end 
end
