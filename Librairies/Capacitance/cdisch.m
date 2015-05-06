function [ cdisch] = cdisch( initial_voltage, bank_inductance, bank_capacitance, bank_resistance, time )
%CDISCH Current discharge of a RLC circuit
%   Detailed explanation goes here
    %% Constants
    damping = 2.*sqrt(bank_inductance./bank_capacitance);
    omega = 1./sqrt(bank_inductance.*bank_capacitance);
    exp_component = -1.*(bank_resistance./(2.*bank_inductance)).*time;
    %% Equations
    if bank_resistance < damping
        cdisch_prefix = initial_voltage./(omega.*bank_inductance);
        cdisch = cdisch_prefix.*exp(exp_component).*sin(omega.*time);
        disp('Under Damped')
    end
    if bank_resistance == damping
        cdisch_prefix = (initial_voltage.*time)./bank_inductance;
        cdisch = cdisch_prefix.*exp(exp_component);
        disp('Critically Damped')
    end
    if bank_resistance > damping
        cdisch_prefix = initial_voltage./((2.*omega).*bank_inductance);
        cdisch = cdisch_prefix.*exp(exp_component).*(exp(omega.*time)-exp(-omega.*time));
        disp('Over Damped')
    end
end