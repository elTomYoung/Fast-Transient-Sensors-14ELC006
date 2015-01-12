function [ bbifilar ] = bbifilar( current, wire_seperation, y_point, z_point)
%bbifilar Magnetic field strength at point P from a bifilar transmission 
%line.
%
%   Magnetic field strength at point P(yp,zp) from a bifilar transmission
%   line carrying current I seperated by distance d.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations 
        % Calculate vecotr components r1, r2 alpha and beta
        vector_components(wire_seperation, y_point, z_point);
        % Result vector z component
        Bz_pre = (u_0/(2*pi))*current;
        Bz = Bz_pre*(((y_point + (wire_seperation/2))/r1^2)-((y_point - (wire_seperation/2))/r2^2));
        % Result vecotr y component
        By_pre = ((u_0*z_point)/(2*pi))*current;
        By = By_pre*((1/(r2^2))-(1/(r1^2)));
        % Result as a vector
        bbifilar = [ Bz By ];
end

function [ r1, alpha, r2, beta ] = vector_components( wire_seperation, y_point, z_point)
%vector_components Works out r1, r2 and angles alhpa and beta from point P
%for a bifilar transmission line.
%
%   Part of bbifilar function, see 'bbifilar' for more details.
%

%% Constants
    %None
%% Equations 
        %r1
        r1 = sqrt((y_point + (wire_seperation/2))^2 + z_point^2);
        %r2
        r2 =sqrt((y_point - (wire_seperation/2))^2 + z_point^2);
        %alpha
        alpha = tan(z_point/(y_point + (wire_seperation/2)));
        %beta
        beta = tan(z_point/(y_point - (wire_seperation/2)));
end