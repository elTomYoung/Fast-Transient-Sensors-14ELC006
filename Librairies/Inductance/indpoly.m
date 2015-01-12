function [ indpoly ] = indpoly( polygon_type, varargin )
%indpoly Inductance of a number of polygon shapes
%
%   Inductance of a polygon shape s defined as 'polygon'. For corret
%   calcualtion of sel inductance input are defined as;
%   
%       'RoundWire', wire_length, wire_radius
%       'RoundWireHF', wire_length, wire_radius
%       'Rectangle', side_length1, side_length2, wire_radius
%       'Planar', perimeter, area, wire_radius
%       'EqTriangle', side_length, wire_radius
%       'Square', side_length, wire_radius
%       'Pentagon', side_length, wire_radius

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    switch polygon_type
        case 'RoundWire'
            wire_length = varargin{1};
            wire_radius = varargin{2};
            indpoly_pre = (u_0*wire_length)/(2*pi);
            indpoly = indpoly_pre*(log((2*wire_length/wire_radius))-(3/4));
        case 'RoundWireHF'
            wire_length = varargin{1};
            wire_radius = varargin{2};
            indpoly_pre = (u_0*wire_length)/(2*pi);
            indpoly = indpoly_pre*(log(2*wire_length/wire_radius)-1);
        case 'Rectangle'
            a = varargin{1};
            b = varargin{2};
            r = varargin{3};
            d = sqrt(a^2 + b^2);
            l = 2*(a + b);
            indpoly_pre = u_0/pi;
            indpoly = indpoly_pre*(a*log((2*a*b)/((a+d)*r))+b*log((2*a*b)/((b+d)*r))+2*d - (7/8)*l);
        case 'Planar'
            P = varargin{1};
            A = varargin{2};
            r = varargin{3};
            indpoly_pre = (u_0*P)/(2*pi);
            indpoly = indpoly_pre*(log((2*P)/r)+(1/4)-log((P^2)/A));
        case 'EqTriangle'
            s = varargin{1};
            r = varargin{2};
            indpoly_pre = (3*u_0*s)/(2*pi);
            indpoly = indpoly_pre*(log(s/r)-1.15546);
        case 'Square'
            s = varargin{1};
            r = varargin{2};
            indpoly_pre = (4*u_0*s)/(2*pi);
            indpoly = indpoly_pre*(log(s/r)-0.52401);
        case 'Pentagon'
            s = varargin{1};
            r = varargin{2};
            indpoly_pre = (5*u_0*s)/(2*pi);
            indpoly = indpoly_pre*(log(s/r)-0.15914);
        otherwise
            disp(' Incorrect input statements, type help indpoly for supported types')
    end
end
