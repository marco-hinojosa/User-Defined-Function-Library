function [q_svd,Q_svd] = qsvd(rN,rB,stddev)
% SVD Algorithm for Static Attitude Estimation
% Note: The rotation is from the body frame to the inertial frame.
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

for ii=1:size(rB,2)
    B = B + rB(:,ii)*rN(:,ii)'/stddev;
end

[U,S,V] = svd(B');
Q_svd = U*diag([1,1,det(U)*det(V)])*V';
q_svd = rot2q(Q_svd);

% Generate Rotation Error
% Q_error = Q_true'*Q_NB_SVD;
% e = unhat(logm(Q_error));
% th_e = 180/pi*norm(e);
