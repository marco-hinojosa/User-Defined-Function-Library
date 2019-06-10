 function R = rotz(alpha)
% rotz  Converts  from  angle in radians into a rotation matrix about z
%
% Inputs:
%   alpha - rotation angle [rad]
%
% Outputs:
%       M - rotation matrix

R = [cos(alpha) -sin(alpha) 0; ...
     sin(alpha)  cos(alpha) 0; ...
              0           0 1];
    
end