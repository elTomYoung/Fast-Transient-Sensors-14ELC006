function [ ctrans ] = ctrans( distance_between_wires, radius, varargin )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %% Constants
        e_0 = 8.854*10^-12;
    %% Equations
    if length(varargin) > 0 
        e_r = [varargin{1}];
        area = [varargin{2}];
        d1 = [varargin{3}];
        d2 = [varargin{4}];
        ctrans = (e_r*e_0*area)/(e_0*d1+e_r*d2);
    else
        ctrans = (pi*e_0)/log(distance_between_wires/radius);
    end
end