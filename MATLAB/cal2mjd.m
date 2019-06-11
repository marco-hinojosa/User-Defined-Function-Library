function mjd = cal2mjd(M, D, Y, H)
% cal2mjd  Converts  UT1  time in  calendar  form to UT1  time in MJD
%
% Inputs:
%       M - Calendar Month
%       D - Calendar Day
%       Y - Calendar Year
%
% Outputs:
%       mjd - Modified Julian Date [d]

if M  <= 2
    y = Y - 1;
    m = M + 12;
else
    y = Y;
    m = M;
end

% Account  for  Leap  Days:
% "Every year whose number is divisible by four is a leap year, except when
% it is also divisible by one hundred. However, those years where the year 
% number is divisible by four hundred are again leap years."
B = Y/400 - Y/100 + Y/4;

mjd = 365*y - 679004 + floor(B) + floor(30.6001*(m + 1)) + D + H/24;