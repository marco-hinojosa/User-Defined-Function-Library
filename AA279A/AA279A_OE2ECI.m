function [r,v] = AA279A_OE2ECI(a,e,i,RAAN,om,nu,mu)
% Compute Mean Motion and Eccentric Anomaly from Known OE
n = sqrt(mu/a^3); % Mean Motion [rad/s]
E = acos((e + cos(nu))/(1 + e*cos(nu))); % Eccentric Anomaly [rad]

% Define Radius and Velocity of Orbit in Perifocal Coordinates
r_pqw = [a*(cos(E) - e); a*sqrt(1 - e^2)*sin(E); 0];
v_pqw = (a*n)/(1 - e*cos(E))*[-sin(E); sqrt(1 - e^2)*cos(E); 0];

% Rotation Matrix Based on Orbit Shape/Inclination
if i == 0 && e ~= 0 % Equatorial/Elliptical
    R = rotz(om);
elseif e == 0 && i ~= 0 % Circular/Inclined
    R = rotz(RAAN)*rotx(i);
elseif i == 0 && e == 0 % Equatorial/Circular
    R = 1;
else % Elliptical/Inclined
    R = rotz(RAAN)*rotx(i)*rotz(om);
end
    
% Rotate Position and Velocity Vectors into ECI Frame
r = R*r_pqw;
v = R*v_pqw;
end 