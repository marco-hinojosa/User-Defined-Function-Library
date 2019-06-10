function [r_pqw, v_pqw] = OE2PQW(a, e, i, RAAN, w, anom, mu)
% OE2ECI Converts orbital elements to r, v in perifocal frame
%
%   Notes: 
%       In cases of equatorial and/or circular orbits, it is assumed
%       that valid orbital elements are provided as inputs (ie. there is 
%       no back-end validation)
%
% Inputs:
%      a - semi-major axis of orbit [km]
%      e - eccentricity of orbit
%      i - inclination of orbit [deg]
%      RAAN - right ascension of the ascending node [deg]
%      w - argument of periapsis [deg]
%      anom - true anomaly [deg]
%      mu - central body gravitational parameters [km^3/s^2]
%
% Outputs:
%   r_eci - 3x1 vector of radius in PQW frame [km]
%   v_eci - 3x1 vector of velocity in PQW frame [km/s]

% Compute Mean Motion and Eccentric Anomaly
n = sqrt(mu/a^3);      % rad/s
E = KeplerEq(deg2rad(anom), e, 1e-6);    % rad

% Compute Radius and Velocity of Orbit in Perifocal Coordinates
r_pqw = [a*(cos(E) - e); a*sqrt(1 - e^2)*sin(E); 0];
v_pqw = (a*n)/(1 - e*cos(E))*[-sin(E); sqrt(1 - e^2)*cos(E); 0];
end 