function [ freqrespreal ] = freqrespreal( omega, inductance, resistance, capacitance_par )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %% Constants
    %None
    %% Equations
    freqresp_num = 1+((1i.*omega.*inductance)./resistance);
    freqresp_denum = 1+((1i.*omega).^2.*inductance.*capacitance_par)+(1i.*omega.*resistance.*capacitance_par);
    freqrespreal = resistance.*(freqresp_num./freqresp_denum);
end