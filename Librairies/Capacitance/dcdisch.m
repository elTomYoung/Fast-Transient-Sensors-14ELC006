function [ cdisch, dcdisch, damping_string] = dcdisch( initial_voltage, bank_inductance, bank_capacitance, bank_resistance, time )
%CDISCH Current discharge and its differential of a RLC circuit
%   Detailed explanation goes here
    %% Constants
    damping = 2.*sqrt(bank_inductance./bank_capacitance);
%     gamma = 0.5.*bank_resistance.*sqrt(bank_capacitance./bank_inductance);
    omega = sqrt((1./(bank_inductance.*bank_capacitance))-((bank_resistance./(2.*bank_inductance))^2));
    omegadot1 = (bank_resistance./(2*bank_inductance))^2;
    omegadot2 = 1./(bank_inductance*bank_capacitance);
    omegadot = sqrt(omegadot1-omegadot2);
%     omega = (1./sqrt(bank_inductance.*bank_capacitance)).*sqrt(1-(gamma^2));
    exp_component = -1.*(bank_resistance./(2.*bank_inductance)).*time;
    %% Equations
    if bank_resistance < damping
        cdisch_prefix = initial_voltage./(omega.*bank_inductance);
        cdisch = cdisch_prefix.*exp(exp_component).*sin(omega.*time);
        dcdisch_prefix = initial_voltage./(omega.*bank_inductance);
        dcdisch = dcdisch_prefix.*((omega.*exp(exp_component).*cos(omega.*time))+((-1.*(bank_resistance./(2.*bank_inductance))).*exp(exp_component).*sin(omega.*time)));
        damping_string = 'Under Damped';
    end
    if bank_resistance == damping
        cdisch_prefix = (initial_voltage.*time)./bank_inductance;
        cdisch = cdisch_prefix.*exp(exp_component);
        dcdisch = ((initial_voltage./bank_inductance).*exp(exp_component))+(-bank_resistance.*((initial_voltage.*time)./(2.*bank_inductance.*bank_inductance)).*exp(exp_component));
        damping_string = 'Critcally Damped';
    end
    if bank_resistance > damping
        cdisch_prefix = initial_voltage./((2.*omegadot).*bank_inductance);
        cdisch = cdisch_prefix.*exp(exp_component).*(exp(omegadot.*time)-exp(-omegadot.*time));
        dcdisch = cdisch_prefix.*((exp(exp_component).*(omegadot.*exp(omegadot.*time)+omegadot.*exp(-omegadot.*time)))+(-1.*(bank_resistance./(2.*bank_inductance)).*exp(exp_component).*(exp(omegadot.*time)-exp(-omegadot.*time))));
        damping_string = 'Over Damped';
    end
end