function [S] = resample_band2 (aster_func, lab_func)
% Function for resample lab data to sensor data
%
% IN:
% aster_func = response function of aster TIR - 1st colum: wavelenght
%                                               2nd colum: response
% lab_func   = lab measures of target - 1st colum: wavelenght
%                                       2nd colum: radiance
%
% OUT: 
% 
% S            = radiance values resampled to sensor data
% 
%
pos = [];
%
% select wavelenghts of lab measure closer to wavelenghts of response 
% function
for i = 1 : size(aster_func,1)
    
    [m,mpos] = min(abs(aster_func(i,1) - lab_func(:,1)));
    clear m
    
    pos = [pos;mpos];
    
end;

lab_func = lab_func(pos,:);

% weight wavelenghts by its response function
w = sum(aster_func(:,2).*lab_func(:,2));

% sum of weights from responde function 
u = sum(aster_func(:,2));

S = w/u;
   
end

