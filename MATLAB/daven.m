function [q_dav,Q_dav] = daven(rN,rB,stddev)
% Davenport q-Algorithm for Static Attitude Estimation
% Note: The rotation is from the body-frame to the inertial frame.
%
% Inputs:
%       rN - 3xN Array of Inertial-Frame Position Vectors
%       rB - 3xN Array of Body-Frame Measured Position Vectors
%       stddev - Standard Deviation Error of Measurements
%
% Outputs:
%       Q - 3x3 Rotation Matrix
%       q - 4x1 Scalar-Last Quaternion

% Generate Attitude Profile Matrix
B = zeros(3);
Z = zeros(3,1);

for ii=1:size(rB,2)
    B = B + rB(:,ii)*rN(:,ii)'/stddev;
    Z = Z + cross(rB(:,ii),rN(:,ii))/stddev;
end

K = [B + B' - trace(B)*eye(3) Z;Z' trace(B)];
[eigvec, eigval] = eig(K);
[~, idx] = max(diag(eigval));

q_dav = eigvec(:,idx)/norm(eigvec(:,idx));
Q_dav = rotm2Q(q_dav);
