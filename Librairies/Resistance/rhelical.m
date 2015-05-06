function [ wire_resis, wire_length ] = rhelical( coil_height, wire_thickness, pitch, resistivity, varargin )
%rhelical Resistace of a helical coil made from a wire with constant pitch.
%   Resistance of a helical coil of length l, made from a wire turned with
%   a constant pitch on a mandral with constant radius r or varying radius 
%   r1, r2.
    if length(varargin) == 1 
        length_pre = coil_height./pitch;
        length_coil = length_pre.*sqrt((2.*pi.*varargin{1}/2).^2 + pitch.^2);
    else
        r1 = varargin{0};
        r2 = varargin{1};
        alpha = (r2-r1)./coil_height;
        c_pre = (pitch./(2*pi)).^2;
        c = c_pre.*(1+tan(alpha)^2);
        a = sqrt((r2.^2)+(c.^2));
        b = sqrt((r1.^2)+(c.^2));
        length_pre = pi./(pitch.*tan(alpha));
        length_coil = length_pre.*((a.*r2)-(b.*r1)+c.*log((a.*r2)./(b.*r1)));
    end
    wire_resis = rwire(resistivity,length_coil,wire_thickness/2);
    wire_length = length_coil;
end

