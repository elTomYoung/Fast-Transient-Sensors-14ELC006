function [ g ] = g( gamma )
%EXPGAMMA Function expressing the I expression of gamma.
%   Detailed explanation goes here

    g_pre = (-1.*gamma)./sqrt(1-(gamma.^2));
    g = exp(g_pre.*asin(sqrt(1-(gamma.^2))));

end

