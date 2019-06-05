function [qhat] = qmult(q)
% Quaternion Hat Operator: Convert Quaternion into a 4x4 Square Matrix
%
% Inputs:
%       q - 4x1 Scalar-Last Quaternion
% Outputs:
%       qhat - 4x4 Matrix

v = q(1:3);
s = q(4);
qhat = [s*eye(3) + vec2skew(v)  v ; -v' s]; 
