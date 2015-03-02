function [ rstrip ] = rstrip( starting_width, ending_width, length, thickness, resistivity )
%rstrip Resistace of a plate of thickness d with variable width.
%   Resistance of a strip conductor made of a material with resistivity ro,
%   with length l. Strip conductor has a variable width starting from a and
%   ending at b.
    Strip_pre = length./((ending_width-starting_width).*thickness);
    rstrip = resistivity.*Strip_pre.*log(ending_width./starting_width);

end

