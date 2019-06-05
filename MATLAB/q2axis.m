function phi = q2axis(q)
% Converts Rotation Matrix Q into Quaternion q
% Input - q Quaternion Matrix 
% Output - phi Axis Angle
Q = q2rot(q);
phi = unhat(logm(Q));
end
