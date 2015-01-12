function [ indtoroid ] = indtoroid( coil_turns, inner_radius, outer_radius, coil_height, core_permeability )
%indtoroid Inductance of a transmission line made from two parallel wires.
%
%   Inductance of a transmission line made from two parallel lines with
%   radius a, seperation d carrying he same current in oppoite directions.
%   The output of this function is in two parts, one is the total self
%   inductance and the second includes the inner self inductance of the
%   toroidal coil.

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    indtoroid_pre = (core_permeability*coil_turns^2*coil_height)/(2*pi);
    res = indtoroid_pre*log(outer_radius/inner_radius);
    indtoroid = [res (res+((u_0*N*(inner_radius+outer_radius))/(2*pi)))];
end
