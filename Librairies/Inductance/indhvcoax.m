function [ indhvcoax ] = indhvcoax( outer_radius, bar_radius, inner_radius, wire_radius, number_of_bars )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    u0 = 4*pi*10^-7;  % H/m
    LHVPre = u0./(2*pi);
    LHV1 = log(outer_radius./wire_radius);
    LHV2 = (inner_radius^4)./(((wire_radius^2)-(inner_radius^2))^2);
    LHV3 = log(wire_radius./inner_radius);
    LHV4 = 0.5*(((3*inner_radius^2) - (wire_radius^2))./((wire_radius^2)-(inner_radius^2)));
    LHV5 = (1./(4*number_of_bars))+((1./number_of_bars).*log(outer_radius./(number_of_bars.*bar_radius)));
    indhvcoax = LHVPre.*(LHV1+(LHV2.*LHV3)-LHV4+LHV5);
end

