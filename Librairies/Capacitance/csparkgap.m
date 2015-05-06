function [ csparkgap ] = csparkgap( sphere_radius, spark_gap, N )
%CSPARKGAP Calculates spark gap capacitance
%       Calculates self capacitance of a spark gap with sphere radius 'R' 
%       and spark gap length 'gap'.
%
%       N is an empirical value.
   %% Constants
    E0 = 8.85*10^-12;
   %% Equation
    csparkgap_pre = pi.*E0.*sqrt((((2*sphere_radius)+spark_gap)^2)-(4*(sphere_radius^2)));
    csparkgap_end = zeros(N,1);
    for j=0:1:N
        csparkgap_end(j+1) = coth((j+0.5).*acosh(((2.*sphere_radius)+spark_gap)./(2.*sphere_radius)))-1;
    end
    csparkgap=csparkgap_pre.*sum(csparkgap_end);

end

