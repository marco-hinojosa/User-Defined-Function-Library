function [r_pqw, v_pqw] = oe2pqw(a, e, i, RAAN, w, anom, mu)
% OE2ECI Converts orbital elements to r, v in perifocal frame
% Notes: 
%       In cases of equatorial and/or circular orbits, it is assumed
%       that valid orbital elements are provided as inputs (i.e. there is 
%       no back-end validation)
%
% Inputs:
%       a - Semi-Major Axis of Orbit [km]
%       e - Eccentricity of Orbit
%       i - Inclination of Orbit [deg]
%       RAAN - Right Ascension of the Ascending Node [deg]
%       w - Argument of Periapsis [deg]
%       anom - True Anomaly [deg]
%       mu - Central Body Gravitational Parameters [km^3/s^2]
%
% Outputs:
%       r_pqw - 3x1 Vector of Radius in PQW Frame [km]
%       v_pqw - 3x1 Vector of Velocity in PQW Frame [km/s]

% Compute Mean Motion and Eccentric Anomaly
n = sqrt(mu/a^3);      % [rad/s]
E = keplerEq(deg2rad(anom), e, 1e-6);    % [rad]

% Compute Radius and Velocity of Orbit in Perifocal Coordinates
r_pqw = [a*(cos(E) - e); a*sqrt(1 - e^2)*sin(E); 0];
v_pqw = (a*n)/(1 - e*cos(E))*[-sin(E); sqrt(1 - e^2)*cos(E); 0];