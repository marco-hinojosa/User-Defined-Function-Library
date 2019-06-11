function [a, e, i, RAAN, w, anom, ang] = eci2oe(r_eci, v_eci, mu)
% ECI2OE  Converts r and v in the ECI  frame  to  orbital  elements
% Notes:
%       This function is able to handle any orbit type, including
%       equatorial and circular orbits. The output ang will output the
%       following values for each orbit type:
%
%       1) Elliptical & Equatorial:
%          - Longitude of Periapsis, Pi = RAAN + w
%       2) Circular & Inclined:
%          - Argument of Latitude, u = w + anom
%       3) Circular & Equatorial:
%          - True Latitude, lambda = RAAN + w + anom
%
%       Otherwise, ang will be undefined (NaN)
%
% Inputs:
%       r_eci - 3x1  Vector  of  Radius  in ECI  Frame [km]
%       v_eci - 3x1  Vector  of  Velocity  in ECI  Frame [km]
%       mu - Gravitational  Parameter  of  Central  Body [km^3/s^2]
%
% Outputs:
%       a - Semi-Major Axis of Orbit [km]
%       e - Eccentricity of Orbit
%       i - Inclination of Orbit [deg]
%       RAAN - Right Ascension of the Ascending Node [deg]
%       w - Argument of Periapsis [deg]
%       anom - True Anomaly [deg]
%       ang - Extra Placeholder Angle for Special Cases [deg]

% Compute Magnitudes
r = norm(r_eci);
v = norm(v_eci);

% Compute Necessary Vectors
hVec = cross(r_eci, v_eci);
h = norm(hVec);

nVec = cross([0, 0, 1], hVec);
n = norm(nVec);

eVec = (1/mu)*((v^2 - mu/r)*r_eci  - dot(r_eci, v_eci)*v_eci);
e = norm(eVec);

% Compute the Size of the Orbit
mechEnergy = 0.5*v^2 - mu/r;
if e ~= 1
    a = -mu/(2*mechEnergy);
    p = a*(1 - e^2);
else
    a = inf;
    p = h^2/mu;
end

% Compute the Orientation of the Orbit
i = acosd(hVec(3)/h);
RAAN = acosd(nVec(1)/n);
w = acosd(dot(nVec, eVec)/(n*e));
anom = acosd(dot(eVec, r_eci)/(e*r));

% Place Angles in the Correct Domains
if nVec (2) < 0
    RAAN = 360 - RAAN;
end
if eVec (3) < 0
    w = 360 - w;
end
if dot(r_eci, v_eci) < 0
    anom = 360 - anom;
end

% Account for any Special Cases
if i == 0 && e ~= 0 % Elliptical & Equatorial
    % Provide the Longitude of Periapsis (Pi = RAAN + w)
    ang = acosd(eVec(1)/e);
    
    if eVec (2) < 02
        ang = 360 - ang;
    end
elseif i ~= 0 && e == 0 % Circular & Inclined
    % Provide the Argument of Latitude (u = w + anom)
    ang = acosd(dot(nVec, r_eci)/(n*r));
    
    if r_eci (3) < 0
        ang = 360 - ang;
    end
elseif i == 0 && e == 0 % Circular & Equatorial
    % Provide the True Latitude (lambda = RAAN + w + anom)
    ang = acosd(r_eci(1)/r);
    
    if r_eci(2) < 0
        ang = 360 - ang;
    end
else
    % Default Output for Ang
    ang = NaN;
end
end










