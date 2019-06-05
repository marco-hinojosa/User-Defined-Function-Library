function [Q] = q2rot(q)
% Converts Quaternion into Rotation Matrix
%
% Inputs:
%       q - 4x1 Scalar-Last Quaternion
%
% Outputs:
%       Q - 3x3 Rotation Matrix

v = q(1:3);
s = q(4);
Q = eye(3) + 2*vec2skew(v)*(s*eye(3) + vec2skew(v));
