function [E,R] = BB(T,EXP)


c = 2.9979*10^8; % speed of light m/s
h = 6.6261*10^-34; % Planck's constant J s
k = 1.3807*10^-23; % Boltzmann's constant J/K

L = EXP(:,1).*(10^(-6));

A = 2*pi*h*(c^2);
B = (h.*c)./(L.*k.*T);
C = exp(B)-1;

E = (A./(L.^5)).*(1./C);

R = [];
for i = 1 : size(EXP(:,2),1)
    R(i) = E(i)*EXP(i,2);
end;

end