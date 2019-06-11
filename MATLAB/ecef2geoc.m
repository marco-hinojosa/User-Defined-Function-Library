function [lambda, phi, h] = ecef2geoc(x, y, z)
% ecef2geoc Converts ECEF coordinates to geocentric latitude and longitude
%
% Inputs:
%       x - ECEF x-coordinate [km]
%       y - ECEF y-coordinate [km]
%       z - ECEF z-coordinate [km]
%
% Outputs:
%       lambda - Geocentric Longitude [deg]
%       phi - Geocentric Latitude [deg]
%       h - Geocentric Altitude [km]

rE = 6378.1; % Earth Equatorial Radius
r = sqrt(x.^2 + y.^2 + z.^2) ;
lambda = rad2deg(atan2(y, x));
phi = rad2deg(asin(z./r));
h = r - rE*ones(length(r), 1);