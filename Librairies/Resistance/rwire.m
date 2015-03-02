function [ rwire ] = rwire( resistivity, length, radius )
%rwire rwiretace of a wire of length l, with cross sectional area A, made
%of a material with risitivity ro.
%   rwiretace of a wire derived from Ohm's law.
    cross_sectional_area = pi.*(radius.^2);
    rwire = resistivity.*(length./cross_sectional_area);

end

