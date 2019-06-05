function [q] = rot2q(Q)
% Converts Rotation Matrix into Quaternion
%
% Inputs:
%       Q - 3x3 Rotation Matrix
%
% Outputs:
%       q - 4x1 Scalar-Last Quaternion

phi = skew2vec(logm(Q));
theta = norm(phi);

if theta ~= 0
    r = phi/theta;
    q = [r*sin(theta/2); cos(theta/2)];
else
    q = [0; 0; 0; 1]; % Identity Quaternion
end
