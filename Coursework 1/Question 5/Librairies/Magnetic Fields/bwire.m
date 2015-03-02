function [ bwire ] = bwire( wire_length, current, y_point, z_point)
%bwire Magnetic field strength at point P from a wire.
%
%   Magnetic field strength at point P(r,zp) from a wire of legnth L
%   carrying current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations       
        % Inside conductor
        prefix = ((u_0*current)/(4*pi*y_point));
        diff = wire_length - z_point;
        bwire = prefix*((diff/sqrt(diff^2+y_point^2))+(z_point/sqrt(z_point^2+y_point^2)));
end
