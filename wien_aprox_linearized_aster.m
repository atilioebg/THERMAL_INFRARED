function [W] = wien_aprox_linearized_aster (L,rad,emi)
% Calculates the linearized radiance for ASTER resampled bands
%
% IN:
% L   = wavelenght;
% Rad = radiance;
% EMI = emissivity;
% 
% OUT:
% W = linearized radiance;

C1 = 1.191042e8;    % <=== first radiation constant (W mu^4 m^-2 sr^-1) 

em = log(mean(emi,2));

for i = 1 : size(rad,1)
    for j = 1 : size(rad,2)  
        
        % Linearized radiance by Wien's aproximation for temperature 
        % isolated
        W(i,j) = L*em - L*log(rad(i,j)) + L*log(C1) - 5*L*log(L)...
                                                         - L*log(pi);

    end;    
end;

end
