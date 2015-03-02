function [ rdisc ] = rdisc( inner_radius, outer_radius, thickness, resistivity )
%rdisc Resistace of a disc placed at ouput of a transmission line.
%   Resistance of a codicting disc made of material with resistivity ro and
%   thickness d.

    rdisc = (resistivity./(2.*pi.*thickness))*log(outer_radius./inner_radius);

end

