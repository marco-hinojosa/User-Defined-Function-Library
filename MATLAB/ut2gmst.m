function gmst = ut2gmst(cal, t)
% ut2gmst Converts from UT1 time to GMST
%
% Inputs:
%       cal - Vector Containing Date of Epoch as [YYYY, MM, DD]
%             Note: Partial days represented with a decimal value.
%       t - Elapsed Time from Epoch [s]
%
% Outputs:
%       gmst - Current Greenwich Mean Sidereal Time [rad]

year = cal(1);
month = cal (2);
startDay = cal (3);

day = startDay + t/86400;
mjd = cal2mjd(year, month, day);
gmst = mjd2gmst(mjd);