function [ mindcoil ] = mindcoil( loop1_radius, loop2_radius, loop_distance )
%mindcoil Magnetic field strength at point P from a current loop along axis.
%
%   Magnetic field strength at point P(xp,yp,zp) from a current loop of
%   radius a carrying current I.
%

%% Constants
    u_0 = 4.*pi.*10.^-7;
%% Equations       
    % Calculate k and Legendre equations
    k = (2.*sqrt(loop1_radius.*loop2_radius))./sqrt((loop1_radius+loop2_radius).^2+loop_distance.^2);
    [K, E] = ellipke(k);
    mindcoil_pre = (2.*u_0.*sqrt(loop1_radius.*loop2_radius))./k;
    % Output result
    mindcoil = mindcoil_pre.*((1-((k.^2)./2)).*K-E);
end
