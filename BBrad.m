function [Ebb,Rad] = BBrad(temp,LAMB,EMI)
% Calculates the radiance by Planck's function and the blackbody radiation 
% at the same temperature
%
% IN:
% temp = temperature (celsius);
% LAMB = wavelenght in micrometer (without cientific notation(x10^y));
% EMI  = emissivity;
% 
% OUT:
% Ebb  = blackbody emission;
% Rad  = radiancia

% convert celsius to kelvin
T = convtemp(temp,'C','K');

%**************************************************************************
%**************************************************************************
% c = 2.9979*10^8; % speed of light m/s
% h = 6.6261*10^-34; % Planck's constant J*s
% k = 1.3807*10^-23; % Boltzmann's constant J/K
%**************************************************************************
%**************************************************************************

C1 = 1.191042e8;    % <=== first radiation constant (W mu^4 m^-2 sr^-1) 

C2 = 1.4387752e4;   % <=== second radiation constant (mu K)

Ebb = [ ];
Rad = [ ];

    for i = 1 : size(T,2)

        A = C2./(LAMB.*T(i));

        B = (exp(A))-1;

        E = C1./((LAMB.^5).*(B)); % <==== blackbody radiation by Planck 

        R = E.*EMI(:,i); % <============= radiance at sensor
        
        Ebb = [Ebb E];
        
        Rad = [Rad R];

    end;

end