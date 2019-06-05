function phi = q2axis(q)
% Converts Quaternion q into Axis-Angle Vector phi
%
% Inputs:
%       q - 4x1 Scalar-Last Quaternion
%
% Outputs:
%       phi - 3x1 Axis Angle Vector [rad]

Q = q2rot(q);
phi = skew2vec(logm(Q));
