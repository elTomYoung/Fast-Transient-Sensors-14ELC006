function [ bidealtoroid ] = bidealtoroid( radius, current, circular_turns )
%btoroid Magnetic field strength inside an ideal toroidal coil
%wire.
%   Magnetic field strength inside an ideal toroidal coil with a radius r,
%   carrying current I with circular turns R.
%


%% Constants
    u_0 = 4*pi*10^-7;
%% Equations       
        % Inside conductor
        bidealtoroid = (u_0*circular_turns*current)/(2*pi*radius);
end
