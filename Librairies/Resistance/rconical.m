function [ rconical ] = rconical( starting_radius, ending_radius, length, resistivity )
%rconical Resistace of a conical conductor of length l, with variable
% cross sectional area A, made of a material with risitivity ro.
%   Resistance of a conical conductor of length l with varable cross
%   section over length c.

    rconical = resistivity.*(length./(pi.*starting_radius.*ending_radius));

end