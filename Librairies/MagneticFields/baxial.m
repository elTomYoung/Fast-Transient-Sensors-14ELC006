function [ baxial ] = baxial( a,r,z,l,I )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    u0 = 4*pi*10.^-7;
    Bz_pre = (u0.*I)./(4.*pi.*l);
    y = a./l;
    d = r./a;
    zd = z./(l./2);
    axial_flux = @(x) ((1-(d.*cos(x)))./(1+(d.^2)-(2.*d.*cos(x)))).*(((1-zd)./sqrt((y.^2).*(1+(d.^2)-(2.*d.*cos(x)))+((1-zd).^2)./4))+((1+zd)./sqrt((y.^2).*(1+(d.^2)-(2.*d.*cos(x)))+((1-zd).^2)./4)));
    baxial = Bz_pre.*integral(@(x)axial_flux(x),0,pi);
end

