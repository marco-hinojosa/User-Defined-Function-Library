function [q] = axis2q(phi)
% Converts Axis-Angle Vector into Quaternion
%
% Inputs:
%       phi - 3x1 Axis-Angle Vector
%
% Outputs:
%       q - 4x1 Scalar-Last Quaternion

% For Large Angles
if norm(phi) > 10*pi/180 
    theta = norm(phi);
    r = phi/theta;

    q(1:3) = r.*sin(theta/2);
    q(4) = cos(theta/2);
    q = q';
% For Small Angle Approximation
else
    q = [phi./2 ; 1 - 1/8*(phi'*phi)];
    q = q/norm(q);
end
