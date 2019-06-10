function [MJD] = CALENDAR2MJD(MM,DD,YYYY,HH)
% Adjust for Leap Years: 
if MM <= 2
    y = YYYY - 1;
    m = MM + 12;
else
    y = YYYY;
    m = MM;
end
% "Every year whose number is divisible by four is a leap year, except when
% it is also divisible by one hundred. However, those years where the year 
% number is divisible by four hundred are again leap years."
B = YYYY/400 - YYYY/100 + YYYY/4;

MJD = 365*(y) - 679004 + floor(B) + floor(30.6001*(m + 1)) + DD + HH/24;
end