function rot = crf2trf(gmst)
% crf2trf Creates a rotation  matrix  between  CRF  and  TRF systems
%
% Inputs:
%       gmst - Greenwich  Mean  Sidereal  Time [rad]
%
% Outputs:
%       rot - Rotation Matrix from Celestial to Terrestrial Frames

rot = rotz(-gmst);