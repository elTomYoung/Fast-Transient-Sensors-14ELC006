function [ critf ] = critf( resitivity, radius )
%CRITF Calculates critical frequency
%   Calculates ciritcal frequency when the skin effect is equal to the
%   radius of the object.

%% Constants
    u_0 = 4*pi*10^-7;

%% Equations
    critf = resitivity./((radius.^2).*pi.*u_0);

end

