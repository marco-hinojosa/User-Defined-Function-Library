function [q] = qconj(qq)
% Quaternion Conjugate Operator
%
% Inputs:
%       qq - 4x1 Input Scalar-Last Quaternion
%
% Outputs:
%       q - 4x1 Output Scalar-Last Quaternion

v = qq(1:3);
v = -v;
q = [v; qq(4)];
