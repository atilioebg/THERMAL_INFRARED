function [W,Y] = wien_aprox_linearized (t,L,Rad,EMI,EQ)
% Calculates the linearized radiance by Wien's aproximation for Planck's 
% function and the blackbody radiation at the same temperature
%
% IN:
% t   = temperature (celsius);
% L   = wavelenght;
% Rad = radiance;
% EMI = emissivity;
% EQ  = equation to use: 1 - right side of linearized equation
%                        2 - left side of linearized equation
%                        3 - Linearized Wien's aprox. for temp. isolated
% 
% OUT:
% W = linearized Wien's aproximation of Planck's function;
% y = value of C2/T; 


T = convtemp(t,'C','K');

C1 = 1.191042e8;    % <=== first radiation constant (W mu^4 m^-2 sr^-1) 

C2 = 1.4387752e4;   % <=== second radiation constant (mu K)

for j = 1 : size(T,2)
    for i = 1 : size(L,1)
        
          if EQ == 1
              % right side of linearized equation 
              W(i,j) = (L(i)*log(EMI(i,j)) + (L(i)*log(C1))...
                       - 5*L(i)*log(L(i)) - L(i)*log(pi) - (C2/T(j)));

              % left side of linearized equation 
              Y(i,j) = L(i)*log(Rad(i,j));
              
          end;

         if EQ == 2
            % Linearized Wien's aproximation for temperature isolated
            W(i,j) = L(i)*log(EMI(i,j)) - L(i)*log(Rad(i,j)) + ...
                     L(i)*log(C1) - 5*L(i)*log(L(i)) - L(i)*log(pi);
    
            Y(1,j) = (C2/T(j));
            
         end;
                  
         
         if EQ == 3
            % Linearized Wien's aproximation for temperature isolated
            W(i,j) = -0.0513*L(i) - L(i)*log(Rad(i,j)) + ...
                     L(i)*log(C1) - 5*L(i)*log(L(i)) - L(i)*log(pi);
    
            Y(1,j) = (C2/T(j));
            
         end;
    end;
    
end;


end
