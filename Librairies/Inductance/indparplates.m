function [ indparplates ] = indparplates( plate_length, distance_between_plates, varargin )
%indparplates Inductance of a transmission line made from two parallel
%plates
%
%   Inductance of a transmission line made from two parallel lines with
%   radius a, seperation d carrying he same current in oppoite directions.
%   The output of this function is in two parts, one is the total self
%   inductance and the second includes the inner self inductance of the
%   toroidal coil.

%% Constants
    u_0 = 4*pi*10^-7;
%% Equations
    if length(varargin) == 1
        plate_width = varargin{1};
        x = (distance_between_plates)./(plate_width);
        if x > 2
            F = (1/(pi*x))*log((8*(x^2)+1)/(2*x));
        else
            F1 = 1+(1.21*x)-(0.11*x^2);
            F2 = ((x/2)*((1-(x/2))^6));
            F = 1/(F1+F2);
        end
        indparplates = u_0*plate_length*(distance_between_plates/plate_width)*F;
    else
        w1 = varargin{1};
        w2 = varargin{2};
        x1 = (w1+w2)/2;
        x = distance_between_plates/x1;
        if x > 2
            F = (1/(pi*x))*log((8*(x^2)+1)/(2*x));
        else
            F1 = 1+(1.21*x)-(0.11*(x^2));
            F2 = ((x/2)*((1-(x/2))^6));
            F = 1/(F1+F2);
        end
        indparplates = u_0*plate_length*(distance_between_plates/(w1-w2))*log(w1/w2)*F;
    end
end

