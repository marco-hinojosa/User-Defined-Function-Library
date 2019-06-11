function R = R_prec(mjd_1, mjd_2)
% PrecMatrix Computes a precession rotation matrix of equatorial coords
% Notes: This function is based on the IAU prec76.for FORTRAN subroutine.
%
% Inputs:
%       mjd1 - Initial Epoch (Modified Julian Date)
%       mjd2 - Epoch to precess to (Modified Julian Date)
% 
% Output:
%       R - Precession Rotation Matrix

% Initialize Constants
mjd_J2000 = 51544.5;                % J2000 Epoch in MJD

% Interval between J2000 and Start Date (Centuries)
T0 = (mjd_1 - mjd_J2000)/36525;

% Interval over which Precession is Required (Centuries)
T = (mjd_2 - mjd_1)/36525;

% Compute Precession Euler Angles (Degrees)
W = 2306.2181 + (1.39656 - 0.000139*T0)*T0;

zeta  =  -(W + ((0.30188 - 0.000344*T0) + 0.017998*T)*T)*T/3600;

z = -(W + ((1.09468 + 0.000066*T0) + 0.018203*T)*T)*T/3600;

theta = -((2004.3109 - (0.85330 + 0.000217*T0)*T0) - ...
           ((0.42665 + 0.000217*T0) + 0.041833*T)*T )*T/3600;

% Construct Precession Rotation Matrix
R = rotz(-z)*roty(theta)*rotz(-zeta);