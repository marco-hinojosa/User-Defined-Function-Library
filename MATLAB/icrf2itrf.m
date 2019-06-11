function [R,R_pre,R_nut,R_pol] = icrf2itrf(gmst)
% crf2trf Creates a rotation  matrix  between  CRF  and  TRF systems
% Notes: GMST is the total angle of rotation about Earth's axis since the 
%        epoch January 1, 2000 12:00h, which is what the International 
%        Celestial Reference Frame (ICRF) is based upon. This function does
%        not consider perturbation motions (nutation, precession, polar
%        motion, equation of equinoxes, etc.)
%
% Inputs:
%       gmst - Greenwich  Mean  Sidereal  Time [rad]
%
% Outputs:
%       R - Rotation Matrix from Celestial to Terrestrial Frames

R_pre
R_nut
R_pol
R = rotz(-gmst);