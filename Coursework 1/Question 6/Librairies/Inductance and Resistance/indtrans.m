function [ indtrans ] = indtrans( cable_radius, cable_seperation )
%indtrans Inductance of a transmission line made from two parallel wires.
%
%   Inductance of a transmission line made from two parallel lines with
%   radius a, seperation d carrying he same current in oppoite directions.

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    indtrans_pre = u_0/pi;
    indtrans = indtrans_pre*(log((cable_seperation-cable_radius)/cable_radius)+(1/4));
end
