function [ bloop ] = bloop( loop_radius, current, x_point, z_point)
%bloop Magnetic field strength at point P from a current loop along axis.
%
%   Magnetic field strength at point P(xp,yp,zp) from a current loop of
%   radius a carrying current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations       
    if x_point == 0
        % Along axis
        bloop =  (u_0*(loop_radius^2)*current)/(2*((loop_radius^2)+(z_point^2))^(3/2));
    else
        % At point in space P
        % Calculate k and Legendre equations
        k = (2*sqrt(loop_radius*x_point)/sqrt((loop_radius+x_point)^2+z_point^2));
        [K, E] = ellipke(k);
        % Magnetic field r-component
        Br_pre1 = (u_0*current)/(2*pi);
        Br_pre2 = (z_point/(x_point*sqrt((loop_radius+x_point)^2+z_point^2)));
        Br_pre = Br_pre1*Br_pre2;
        Br = Br_pre*((-1*K)+((loop_radius^2+x_point^2+z_point^2)/((loop_radius-x_point)^2+z_point^2))*E);
        % Magnetic field z-component
        Bz_pre1 = (u_0*current)/(2*pi);
        Bz_pre2 = (1/sqrt((loop_radius+x_point)^2+z_point^2));
        Bz_pre = Bz_pre1*Bz_pre2;
        Bz = Bz_pre*(K+((loop_radius^2-x_point^2-z_point^2)/((loop_radius-x_point)^2+z_point^2))*E);
        % Output result
        bloop = [ Br Bz ];
    end
end
