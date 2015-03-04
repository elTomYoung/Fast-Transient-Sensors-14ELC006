function [ f ] = f( gamma )
%ASINGAMMA Function expressing the t expression of gamma.
%   Detailed explanation goes here

    f_pre = 1./sqrt(1-(gamma.^2));
    f = f_pre.*asin(sqrt(1-(gamma.^2)));

end

