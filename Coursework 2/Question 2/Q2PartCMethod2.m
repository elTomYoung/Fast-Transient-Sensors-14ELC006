%% Part C Method 2
% Draw a graphical representation of the resistance variation with 
% frequency up to a frequency of 1GHz.
Rcf = critf(rho,a);
% Loop to calculate resistance with frequency
count = 100;
RT = zeros(count);
Freq = logspace(0,7,count);
for ln = 1:1:count;
    delta = dskin(rho,Freq(ln));
    if delta <= a 
        delta = dskin(rho,Freq(ln));
        Sskin = 2.*a.*pi.*delta.*(1-(delta./(2.*a)));
        Rskin = (Coil_length.*rho)./Sskin;
        RT(ln) = DCResis.*Rskin.*(1+((2.*(a^2))./(p^2)));
    else
        RT(ln) = DCResis;
    end
end
% Plot data
figure
semilogx(Freq,RT./DCResis,'b','linewidth',2)
%semilogx(Freq,RT,'b','linewidth',2)
grid on
xlabel('Frequency')
ylabel('$${F(f,R)\over F(0,0) }$$','Interpreter','Latex')
xlim([0 10*10^6])
ylim([1 inf])
title('Resistance change with Frequency Method 2')