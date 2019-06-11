function gmst = mjd2gmst(mjd)
% mjd2gmst Converts UT1 time in MJD to GMST
%
% Inputs:
%       mjd - Modified Julian Date [d]
%
% Outputs:
%       gmst - Greenwich  Mean  Sidereal  Time [rad]

% Normalize by J2000 Epoch (Jan. 1, 2000  12:00h)
d = mjd - 51544.5;

gmst_deg = 280.4606 + 360.9856473*d;
gmst_rad = deg2rad(gmst_deg);

gmst = mod(gmst_rad, 2*pi);