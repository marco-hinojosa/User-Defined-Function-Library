function E = nu2E(nu, e)
% nu2E Computes eccentric anomaly
%
% Inputs:
%       anom - True Anomaly [rad]
%       e - Eccentricity of Orbit
%
% Outputs:
%       E - Eccentric Anomaly [rad]

E = acos((e + cos(nu))/(1 + e*cos(nu)));

% Make sure E sits in the correct semi-plane
if nu > pi
    E = 2*pi - E;
end
