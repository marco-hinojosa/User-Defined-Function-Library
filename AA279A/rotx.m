function R = rotx(phi)
%ROTX  rotate around X by PHI
%
%	R = ROTX(PHI)
%
% See also: ROTY, ROTZ, ROT, POS.

% $ID$
% Copyright (C) 2005, by Brad Kratochvil

R = [1        0         0; ...
     0 cos(phi) -sin(phi); ...
     0 sin(phi)  cos(phi)];
end