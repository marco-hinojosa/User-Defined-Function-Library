function [a, e, i, RAAN, w, anom] = AA279A_ECI2OE(r,v)
% Initialize Constants
R_E = 6378.14;      % km
mu = 3.986004E5;    % km^3/s^2

% Compute Magnitudes of Vectors
rmag = norm(r);
vmag = norm(v);

% Compute Orbital Elements, Including Quadrant Checks
xi = ((vmag^2)/2) - (mu/rmag);
a = -mu/(2*xi);

e_vec = (((vmag^2 - mu/rmag).*r) - dot(r,v).*v)/mu;
e = norm(e_vec);

h = cross(r,v);
hnorm = norm(h);
i = acosd(h(3)/hnorm);

n = [-h(2);h(1);0];
cosraan = -h(2)/norm(n);
sinraan = h(1)/norm(n);
RAAN = atan2(sinraan,cosraan)*180/pi;
if RAAN < 0
    RAAN = RAAN + 360;
else
end

w = acosd(dot(n,e_vec)/(norm(n)*e));
if e_vec(3) < 0 && w < 180
    w = 360 - w;
else
end

anom = acosd(dot(e_vec,r)/(e*rmag));
if dot(r,v) < 0 && anom < 180
    anom = 360 - anom;
else
end




