function [q] = qconj(qq)
% Quaternion Conjugate Operator
%
% Inputs:
%       qq - 4x1 Input Quaternion
%
% Outputs:
%       q - 4x1 Output Quaternion

v = qq(1:3);
v = -v;
q = [v; qq(4)];
