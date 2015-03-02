function [ binfsheet ] = binfsheet( current, sheet_width, x_point, y_point)
%binfsheet Magnetic field strength at point P from an infinitely long 
%current sheet.
%
%   Magnetic field strength at point P(xp,yp) from a current sheet of
%   inifnite length carrying current I.
%

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
        % Vector Components
        vector_components(sheet_width, x_point, y_point)
        % Prefix
        B_pre = u_0*(current/(2*pi*sheet_width));
        % Result vector x component
        Bx = B_pre*(beta1 - beta2);
        % Result vecotr y component
        By = B_pre*log(r2/r1);
        % Result as a vector
        binfsheet = [ Bx By ];
end

function [ r1, beta1, r2, beta2 ] = vector_components( sheet_width, x_point, y_point )
%vector_components Works out r1, r2 and angles beta 1 and beta 2 from point
%P for an infinitely long current sheet.
%
%   Part of bbifilar function, see 'binfsheet' for more details.
%

%% Constants
    %None
%% Equations 
        %r1
        r1 = sqrt((x_point - sheet_width)^2 + y_point^2);
        %r2
        r2 = sqrt(x_point^2 + y_point^2);
        %beta1
        beta1 = tan(y_point/(x_point - sheet_width));
        %beta2
        beta2 = tan(y_point/x_point);
end
