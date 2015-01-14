function [ ccoil ] = ccoil( coil_radius, pitch, wire_radius, varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %% Constants
        e_0 = 8.854*10^-12;
    %% Equations
        if length(varargin) >0
            m_perm = [varargin{1}];
            t = [varargin{2}];
            F1 = F(pitch,m_perm,t,wire_radius);
            ccoil_num = 2*pi^2*e_0*coil_radius;
            ccoil_dem_1 = (1+(t/wire_radius))^(2/m_perm);
            ccoil_denum = log(F1+sqrt((F1^2)-ccoil_dem_1));
            ccoil = ccoil_num/ccoil_denum;
        else
            ccoil_num = 2*pi^2*e_0*coil_radius;
            ccoil_denum = log((pitch/(2*wire_radius))+sqrt(((pitch/(2*wire_radius))^2)-1));
            ccoil = ccoil_num/ccoil_denum;
        end
end

function [ F ] = F(p, e_r, t ,r)
%     F = p/(2*r*((1+(t/r)^((m-1)/m))));
    F_num = p;
    F_denum1 = (1+(t/r))^((e_r-1)/e_r);
    F_denum2 = 2*r*F_denum1;
    F = F_num/F_denum2;
end