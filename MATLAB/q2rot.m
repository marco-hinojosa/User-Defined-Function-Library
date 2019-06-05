function [Q] = q2rot(q)
% Converts Quaternion into Rotation Matrix
%
% Inputs:
%       q - 4x1 Scalar-Last Quaternion
v = q(1:3);
s = q(4);

Q = eye(3) + 2*hat(v)*(s*eye(3) + hat(v));
end
