function [ indscoil ] = indscoil( coil_radius, coil_length )
%indscoil Inductance of a single turn coil
%
%   Inductance of a single tun coil of length L and radius a

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    y = coil_radius/coil_length;
    indscoil_pre = u_0*((pi*coil_radius^2)/coil_length);
    indscoil = indscoil_pre*(hcy(y)+((2/(alpha(y)+2))*(hey(y)-hcy(y))));
end

function [ hcy ] = hcy( y )
    if y < 0.2
        hcy = 1-(2*y^2)+(6*y^4);
    else
        if y < 0.8
            hcy = 1.0111-(0.162*y)-(1.4179*y^2)+(0.9629*y^3)+(0.1754*y^4);
        else
            hcy = (0.5/y)-(0.0625/(y^3))+(0.0117/(y^5));
        end
    end
end

function [ hey ] = hey( y )
    if y < 0.152
        hey = 1-(2*y^2)+(14.5*y^4);
    else
        if y < 0.489
            hey = 1.023-(0.405*y);
        else
            hey = 0.5-(0.21/(y^0.61));
        end
    end
end

function [ alpha ] = alpha( y )
    alpha = (0.782*y) + 1.5145;
end