function [ indself ] = indself( coil_turns, current, flux_linkage )
%indself Self Inductance 
%
%   Inductanve is the total magnetic flux linkage per unit current.
%

%% Constants
    % None
%% Equations
   indself = ((coil_turns^2)/current)*flux_linkage;   
end
