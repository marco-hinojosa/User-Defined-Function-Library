function [lambda, phi, h] = ecef2geod(x, y, z, eps)
% ecef2geod Converts ECEF coordinates to Geodetic latitude and longitude
%
% Inputs :
% x - ECEF x coordinate [km]
% y - ECEF y coordinate [km]
% z - ECEF z coordinate [km]
% eps - tolerance of coordinate result [deg]
%
% Outputs :
% lambda - Geodetic longitude of orbit [deg]
% phi - Geodetic latitude of orbit [deg]
% h - Geodetic altitude of orbit [km]

rE = 6378.1; % Earth Equatorial Radius 
eE = 0.0818; % WGS84 Ellipsoid Eccentricity

r = sqrt(x.^2 + y.^2 + z.^2);
lambda = atan2d(y, x); % Geocentric Longitude = Geodetic Longitude

phi_i = asin(z./r); % Use geocentric latitude as first guess
N = rE/sqrt(1 - eE^2*(sin(phi_i)^2)); % Modified Radius of Curvature
r_xy = sqrt(x.^2 + y.^2);
diff = 2*eps;

while abs(diff) > eps
    phi1 = atan2d((z + N*eE^2*sin(phi_i)), r_xy);
    diff = phi1 - phi_i;
    phi_i = phi1;
    N = rE/sqrt(1 - eE^2*(sin(phi_i)^2));
end

phi = phi_i;
h = r_xy/cosd(phi) - N;

end