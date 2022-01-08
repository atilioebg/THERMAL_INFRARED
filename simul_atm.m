function [rad_res] = simul_atm(rad, emi, trans, upw, dww, RF)
% Function that calculate the raw radiance of sensor (TOA radiance)
%
% IN:
% rad     = resampled radiance of target without atmospheric contribution 
%           on the format [wavelenght_lab rad];
% emi     = resampled emissivity of target on the format [wavelenght_lab rad];
% trans   = atmospheric transmitance on the format [wavelenght_modtran rad];
% upw     = upwelling radiance (path radiance) on the format 
%           [wavelenght_modtran rad];
% dww     = downwelling radiance (thermal surface emission) on the format 
%           [wavelenght_modtran rad];
% RF      = responde function of sensor on the format [wavelenght_aster rad]
%
% OBS.: 
% wavelenght_lab:  is the wavalenght resolution of spectroradiometer
% wavelenght_modtran:  is the wavalenght resolution of modtran simulation
% wavelenght_aster:  is the wavalenght resolution of aster response function
%
% OUT:
% rad_res = radiance at sensor with atmospheric contribution; 

pos_T = [];
pos_U = [];
pos_D = [];
%
% select the wavelengths greather than or equal 0.5
pos_FWHM = find(RF(:,2) >= 0.5);
RF = RF(pos_FWHM,:);
%
% loop to select the wavelenght closer to the wavelenght os aster response 
% function 
for i = 1 : size(RF,1)
    
    [m,mpost] = min(abs(RF(i,1) - trans(:,1)));
    [m,mposu] = min(abs(RF(i,1) - upw(:,1)));
    [m,mposd] = min(abs(RF(i,1) - dww(:,1)));
          
    clear m; 
    
    pos_T = [pos_T; mpost];
    pos_U = [pos_U; mposu];
    pos_D = [pos_D; mposd];
        
end;

trans = trans(pos_T,:);
upw = upw(pos_U,:);
dww = dww(pos_D,:);

% calculate the mean of atmosferics parameters and emissivity 
Tr = mean(trans(:,2));
Up = mean(upw(:,2));
Dw = mean(dww(:,2));

% calculate the TOA radiance
rad_res = (Tr.*rad(1,2:end)) + (Tr.*(1 - emi(1,2:end)).*Dw) + Up;

end
    