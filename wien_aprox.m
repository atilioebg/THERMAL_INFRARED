function [Ebb_wien,Rad_wien] = wien_aprox(temp,LAMB,EMI)
% Calculates the radiance by Wien's aproximation for Planck's function and
% the blackbody radiation at the same temperature
%
% IN:
% temp = temperature (celsius);
% LAMB = wavelenght;
% EMI  = emissivity;
% 
% OUT:
% Ebb  = blackbody emission;
% Rad  = radiancia

% converts celsius to kelvin
T = convtemp(temp,'C','K');

C1 = 1.191042e8;    % <=== first radiation constant (W mu^4 m^-2 sr^-1) 

C2 = 1.4387752e4;   % <=== second radiation constant (mu K)

Ebb_wien = [ ];

Rad_wien = [ ];

    for i = 1 : size(T,2)

        A = C2./(LAMB.*T(i));

        B = (exp(A));

        E = C1./((LAMB.^5).*(B)); % <======= blackbody radiation by wien

        R = E.*EMI(:,i); % <================ radiance at sensor
        
        Ebb_wien = [Ebb_wien E];
        
        Rad_wien = [Rad_wien R];

    end;

end