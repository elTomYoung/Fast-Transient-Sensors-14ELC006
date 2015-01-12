function [ indhelical ] = indhelical( coil_turns, coil_radius, coil_length )
%indhelical Inductance of a transmission line made from two parallel wires.
%
%   Inductance of a transmission line made from two parallel lines with
%   radius a, seperation d carrying he same current in oppoite directions.
%   The output of this function is in two parts, one is the total self
%   inductance and the second includes the inner self inductance of the
%   toroidal coil.

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    if coil_length >= coil_radius
        K = coil_length/(coil_length+(0.9*coil_radius));
    else
        K = coil_length/((11/10)*coil_length+(0.8*coil_radius));
    end
    indhelical = ((u_0*pi*(coil_turns^2)*(coil_radius^2))/coil_length)*K;
end

