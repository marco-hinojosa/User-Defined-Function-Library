function [r_eci, v_eci] = oe2eci(a, e, i, RAAN, w, anom, mu)
% OE2ECI Converts orbital elements to r, v in inertial frame
% Notes: 
%        In cases of equatorial and/or circular orbits, it is assumed
%        that valid orbital elements are provided as inputs (ie. there is 
%        no back-end validation)
%
% Inputs:
%        a - semi-major axis of orbit [km]
%        e - eccentricity of orbit
%        i - inclination of orbit [deg]
%        RAAN - right ascension of the ascending node [deg]
%        w - argument of periapsis [deg]
%        anom - true anomaly [deg]
%        mu - central body gravitational parameters [km^3/s^2]
%
% Outputs:
%        r_eci - 3x1 vector of radius in ECI frame [km]
%        v_eci - 3x1 vector of velocity in ECI frame [km/s]

% Compute Mean Motion
n = sqrt(mu/a^3);      % [rad/s]

% Solve Kepler's Equation
E = keplerEq(deg2rad(anom),e,1e-6);    % [rad]

% Compute Radius and Velocity of Orbit in Perifocal (PQW) Coordinates
rPeri = [a*(cos(E) - e); a*sqrt(1 - e^2)*sin(E); 0];
vPeriComp = [-sin(E); sqrt(1 - e^2)*cos(E); 0];
vPeri = (a*n)/(1 - e*cos(E))*vPeriComp;

% Develop Rotation Matrix Depending on Orbit Shape/Inclination
if i == 0 && e ~= 0         % Equatorial + Elliptical
    rotPeri2ECI = rotz(w);
elseif e == 0 && i ~= 0     % Inclined + Circular
    rotPeri2ECI = rotz(RAAN)*rotx(i);
elseif i == 0 && e == 0     % Equatorial + Circular
    rotPeri2ECI = 1;
else                        % Inclined + Elliptical
    rotPeri2ECI = rotz(RAAN)*rotx(i)*rotz(w);
end
    
% Rotate vectors into ECI frame
r_eci = rotPeri2ECI*rPeri;
v_eci = rotPeri2ECI*vPeri;
